# Standalone neovim derivation with this config baked in.
# Setting XDG_CONFIG_HOME at launch points neovim to the bundled lua config,
# so `nix run` opens neovim with the full configuration applied.
{
  pkgs,
  lib,
  ...
}:
let
  nvimConfig = pkgs.stdenv.mkDerivation {
    name = "nvim-lua-config";
    src = lib.fileset.toSource {
      root = ./..;
      fileset = lib.fileset.unions [
        ../init.lua
        ../lua
        ../after
        ../lsp
      ];
    };
    installPhase = ''
      mkdir -p $out/nvim
      cp -r lua after lsp init.lua $out/nvim/
    '';
  };
  # Same plugins as home-manager; wrapRc = false keeps init.lua from nvimConfig.
  neovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
    plugins = import ./plugins.nix { inherit pkgs; };
    wrapRc = false;
  };
in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ neovim ];
  text = ''
    XDG_CONFIG_HOME="${nvimConfig}" exec nvim "$@"
  '';
}
