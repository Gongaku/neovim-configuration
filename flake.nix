{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule
        flake-parts.flakeModules.easyOverlay
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        { pkgs, system, config, ... }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              inputs.neovim-nightly-overlay.overlays.default
            ];
          };
          packages.default = inputs.neovim-nightly-overlay.packages.${system}.default;
          treefmt.config = {
            projectRootFile = "flake.nix";
            programs = {
              # Lua
              stylua.enable = true;
              # YAML
              yamlfmt.enable = true;
              yamllint.enable = true;
              # Nix
              deadnix.enable = true; # Check for unused dependencies in nix code
              nixfmt.enable = true; # Nix Formatting
              statix.enable = true; # Lints and suggestions for Nix

              # Bash/Shell
              shellcheck.enable = true;

              # Misc
              keep-sorted.enable = true; # Language-agnostic formatter that sorts lines between two markers in a large file
              prettier.enable = true; # Code Formatter
            };
          };
          overlayAttrs = {
            inherit (config.packages) neovim;
          };
        };
      flake =
        { pkgs, ... }:
        let
          system = pkgs.stdenv.hostPlatform.system;
        in
        {
          programs.neovim = {
            package = inputs.neovim-nightly-overlay.packages.${system}.default;
            withPython3 = true;
            withNodeJs = true;
            configure = {
              customLuaRC = builtins.readFile ./init.lua;
            };
          };
          xdg.configFile."pycodestyle".text = ''
            [pycodestyle]
            ignore = E226,E302,E401,W503,E501
          '';
          home.file.".local/state/nvim/mason/packages/lua-language-server/libexec/bin/lua-language-server".source =
            "${pkgs.lua-language-server}/bin/lua-language-server";
        };
    };
}
