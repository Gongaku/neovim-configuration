# NixOS module for this Neovim configuration.
#
# Usage — add to your nixosConfigurations imports:
# ```nix
#   imports = [ nvim-config.nixosModules.default ];
# ```
#
# Installs neovim-nightly system-wide with plugins and config symlinked into
# /etc/xdg/nvim, which Neovim picks up via XDG_CONFIG_DIRS.
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
  nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlays.default ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
    configure.packages.nvim-config.start = plugins;
  };

  environment = {
    systemPackages = with pkgs; [
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

    etc = {
      "xdg/nvim/init.lua".source = ../init.lua;
      "xdg/nvim/lua".source = ../lua;
      "xdg/nvim/after".source = ../after;
      "xdg/nvim/lsp".source = ../lsp;
    };
  };
}
