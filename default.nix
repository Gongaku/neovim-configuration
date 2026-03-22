{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs:
    let
      forAllSystems =
        function:
        inputs.nixpkgs.lib.genAttrs [ "x86_64-linux" ] (
          system:
          function (
            import inputs.nixpkgs {
              inherit system;
              overlays = [
                inputs.neovim-nightly-overlay.overlays.default
              ];
            }
          )
        );
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.nvim-pkg;
      });
      # packages = {
      #   # "x86_64-linux".default = inputs.nixpkgs.neovim;
      #   programs.neovim = {
      #     enable = true;
      #   };
      # };

      # formatter = forAllSystems (
      #   pkgs:
      # );
    };
}
