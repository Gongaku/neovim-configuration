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
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    # Tree-sitter parsers aren't bundled with the nightly build; ship them as
    # Nix-packaged grammars so render-markdown (html) and treesitter folds work.
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter-parsers.html
      nvim-treesitter-parsers.html.associatedQuery
      nvim-treesitter-parsers.typst
      nvim-treesitter-parsers.typst.associatedQuery
      nvim-treesitter-parsers.yaml
      nvim-treesitter-parsers.yaml.associatedQuery
    ];
    extraPackages = with pkgs; [
      # keep-sorted start
      bash-language-server # Bash language with `shellcheck` & `shfmt` support
      harper # Grammar Checker for developers
      inotify-tools # Simple interface to `inotify` for filesystem events
      lua-language-server # Lua Language Server
      nixd # Nix language server with rich diagnostics
      nixfmt # Nix Formatter
      pyright # Python language server
      ruff # Python linter
      shellcheck # Shell Formatter/Validator
      shfmt # Shell Formatter
      stylua # Lua Formatter
      tinymist # LSP server for Typst
      tree-sitter # Syntax highlighting
      typst # Typst Language
      websocat # Web Sockets
      yaml-language-server # YAML LSP
      # keep-sorted end
    ];
  };

  xdg = {
    # `$XDG_CONFIG_HOME` (`$HOME/.config`)
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
  };
}
