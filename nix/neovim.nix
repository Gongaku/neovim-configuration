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
        ../nix-nvim-pack-lock.json
        ../sync-pack-revs.sh
      ];
    };
    installPhase = ''
      mkdir -p $out/nvim
      cp -r lua after lsp init.lua nix-nvim-pack-lock.json $out/nvim/
    '';
  };
in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ pkgs.neovim ];
  text = ''
    XDG_CONFIG_HOME="${nvimConfig}" exec nvim "$@"
  '';
}
