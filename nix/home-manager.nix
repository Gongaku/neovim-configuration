# Home-manager module for this Neovim configuration.
#
# Usage — add to your home-manager imports:
# ```nix
#   imports = [ nvim-config.homeManagerModules.default ];
# ```
#
# The neovim-nightly package is sourced directly from this flake's
# neovim-nightly-overlay input, so no overlay needs to be applied
# to the caller's `nixpkgs`.
inputs:
{
  pkgs,
  lib,
  ...
}:
let
  plugins = import ./plugins.nix { inherit pkgs lib; };
in
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    withPython3 = true;
    withNodeJs = true;
    plugins = map (p: { plugin = p; }) plugins;
    extraPackages = with pkgs; [
      # keep-sorted start
      bash-language-server
      harper
      inotify-tools
      lua
      lua-language-server
      nixd
      nixfmt
      pyright
      ruff
      shellcheck
      shfmt
      tinymist
      tree-sitter
      typst
      websocat
      yaml-language-server
      # keep-sorted end
    ];
  };

  xdg = {
    configFile = {
      "nvim/init.lua".source = ../init.lua;
      "nvim/lua".source = ../lua;
      "nvim/after".source = ../after;
      "nvim/lsp".source = ../lsp;
      "pycodestyle".text = lib.mkDefault ''
        [pycodestyle]
        ignore = E226,E302,E401,W503,E501
      '';
    };
    stateFile = {
      "nvim/mason/packages/lua-language-server/libexec/bin/lua-language-server".source =
        "${pkgs.lua-language-server}/bin/lua-language-server";
    };
  };
}
