# Plugins shipped by Nix, shared by nix/home-manager.nix and nix/neovim.nix.
# lua/base/plugin-manager.lua skips vim.pack when these are on 'packpath'.
{ pkgs }:
with pkgs.vimPlugins;
[
  # keep-sorted start
  conform-nvim
  focus-nvim
  friendly-snippets
  indent-blankline-nvim
  lualine-nvim
  mini-nvim
  oil-git-nvim
  oil-nvim
  render-markdown-nvim
  tokyonight-nvim
  typst-preview-nvim
  # keep-sorted end
  # Not in nixpkgs
  (pkgs.vimUtils.buildVimPlugin {
    pname = "markdown-plus.nvim";
    version = "0-unstable-2026-11-07";
    src = pkgs.fetchFromGitHub {
      owner = "YousefHadder";
      repo = "markdown-plus.nvim";
      rev = "732b506911693642d8e62d89225639062374686a";
      hash = "sha256-yQGj0oGX6sJYBm67FxneGc9kURmJ5YpxkmdE2nXOQJU=";
    };
  })
  # Tree-sitter parsers aren't bundled with the nightly build; ship them as
  # Nix-packaged grammars so render-markdown (html) and treesitter folds work.
  nvim-treesitter-parsers.html
  nvim-treesitter-parsers.html.associatedQuery
  nvim-treesitter-parsers.typst
  nvim-treesitter-parsers.typst.associatedQuery
  nvim-treesitter-parsers.yaml
  nvim-treesitter-parsers.yaml.associatedQuery
]
