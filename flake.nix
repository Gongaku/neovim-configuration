{
  description = "Neovim Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule
      ];

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
            overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
          };

          packages.default = import ./nix/neovim.nix {
            inherit pkgs;
            inherit (pkgs) lib;
          };

          treefmt.config = {
            projectRootFile = "flake.nix";
            programs = {
              # keep-sorted start
              deadnix.enable = true;
              keep-sorted.enable = true;
              nixfmt.enable = true;
              prettier.enable = true;
              rumdl-format.enable = true;
              shellcheck.enable = true;
              shfmt.enable = true;
              statix.enable = true;
              stylua.enable = true;
              yamlfmt.enable = true;
              # keep-sorted end
            };
            settings.formatter.shfmt.options = pkgs.lib.mkForce [
              "-i"
              "2"
              "-s"
              "-ci"
              "-bn"
              "-sr"
              "-w"
            ];
          };
        };

      flake = {
        homeManagerModules.default = import ./nix/home-manager.nix inputs;
      };
    };
}
