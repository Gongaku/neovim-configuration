# Home-manager module for this neovim configuration.
#
# Usage — add to your home-manager imports:
#   imports = [ nvim-config.homeManagerModules.default ];
#
# The neovim-nightly package is sourced directly from this flake's
# neovim-nightly-overlay input, so no overlay needs to be applied to
# the caller's nixpkgs.
inputs:
{
  pkgs,
  lib,
  ...
}:
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    withPython3 = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      # keep-sorted start
      bash-language-server
      harper
      lua-language-server
      nixd
      pyright
      ruff
      tinymist
      tree-sitter
      yaml-language-server
      # keep-sorted end
    ];
  };

  xdg.configFile = {
    "nvim/init.lua".source = ../init.lua;
    "nvim/lua".source = ../lua;
    "nvim/after".source = ../after;
    "nvim/lsp".source = ../lsp;
    "nvim/nvim-pack-lock.json".source = ../nvim-pack-lock.json;
  };

  xdg.configFile."pycodestyle".text = lib.mkDefault ''
    [pycodestyle]
    ignore = E226,E302,E401,W503,E501
  '';
}
