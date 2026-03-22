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
      imports = [ inputs.treefmt-nix.flakeModule ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        { pkgs, system, ... }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              inputs.neovim-nightly-overlay.overlays.default
            ];
          };
          packages.default = pkgs.neovim;
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
        };
      flake = {
        programs.neovim = {
          configure = {
            customLuaRC = builtins.readFile ./init.lua;
          };
        };
      };
    };
}
