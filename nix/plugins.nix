# Builds a list of Neovim plugin derivations from nix-nvim-pack-lock.json.
# Each entry needs: rev, hash (SRI sha256), src (https://github.com/owner/repo).
{ pkgs, lib }:
let
  lockFile = lib.importJSON ../nix-nvim-pack-lock.json;

  buildPlugin =
    name: entry:
    let
      # src is "https://github.com/owner/repo" — split on "/" gives
      # ["https:" "" "github.com" "owner" "repo"]
      parts = lib.splitString "/" entry.src;
      owner = builtins.elemAt parts 3;
      repo = builtins.elemAt parts 4;
    in
    pkgs.vimUtils.buildVimPlugin {
      pname = name;
      version = builtins.substring 0 8 entry.rev;
      src = pkgs.fetchFromGitHub {
        inherit owner repo;
        inherit (entry) rev;
        inherit (entry) hash;
      };
    };
in
lib.mapAttrsToList buildPlugin lockFile.plugins
