# NixOS module for this Neovim configuration.
#
# Usage — add to your nixosConfigurations imports:
# ```nix
#   imports = [ nvim-config.nixosModules.default ];
# ```
#
# Installs neovim-nightly system-wide with the config symlinked into
# /etc/xdg/nvim, which Neovim picks up via XDG_CONFIG_DIRS.
inputs:
{
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlays.default ];

  environment = {
    systemPackages =
      [
        pkgs.neovim
      ]
      ++ (with pkgs; [
        # keep-sorted start
        bash-language-server # Bash language with `shellcheck` & `shfmt` support
        harper # Grammar Checker for developers
        inotify-tools # Simple interface to `inotify` for filesystem events
        lua # Lua Language
        lua-language-server # Lua Language Server
        nixd # Nix language server with rich diagnostics
        nixfmt # Nix Formatter
        pyright # Python language server
        ruff # Python linter
        shellcheck # Shell Formatter/Validator
        shfmt # Shell Formatter
        tinymist # LSP server for Typst
        tree-sitter # Syntax highlighting
        typst # Typst Language
        websocat # Web Sockets
        yaml-language-server # YAML LSP
        # keep-sorted end
      ]);

    etc = {
      "xdg/nvim/init.lua".source = ../init.lua;
      "xdg/nvim/lua".source = ../lua;
      "xdg/nvim/after".source = ../after;
      "xdg/nvim/lsp".source = ../lsp;
    };
  };
}
