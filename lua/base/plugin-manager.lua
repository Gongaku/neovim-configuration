if vim.version().minor >= 12 then
  local plugins = {}
  local repositories = {
    "stevearc/oil.nvim", -- File Explorer
    "benomahony/oil-git.nvim", -- Git Integration with File Explorer
    "echasnovski/mini.nvim", -- Mini suite: Includes completion, picker, and snippets
    "nvim-treesitter/nvim-treesitter", -- Language parser for syntax highlighting
    "neovim/nvim-lspconfig", -- Default configs for LSP servers
    "mason-org/mason.nvim", -- LSP repositories
    "mason-org/mason-lspconfig.nvim", -- Integration between mason and LSP config
    "rafamadriz/friendly-snippets", -- Snippet collection for different languages
    "MeanderingProgrammer/render-markdown.nvim", -- Render Markdown in terminal
    "folke/tokyonight.nvim", -- Tokyo Night Theme
    "nvim-lualine/lualine.nvim", -- Status line configuration
    "lukas-reineke/indent-blankline.nvim", -- Show indentations
    "nvim-focus/focus.nvim", -- Change focus window size via the golden ratio
    "pablos123/shellcheck.nvim", -- Write better shell scripts
  }

  if not helpers.is_work then
    repositories = {
      "chomosuke/typst-preview.nvim", -- Allows for live-preview of Typst files
      unpack(repositories) -- Unpack other repositories table to combine tables
    }
  end

  for _, plugin in ipairs(repositories) do
    table.insert(plugins, { src = "https://github.com/" .. plugin })
  end

  vim.pack.add(plugins)
else
  error([[Please update to a newer version of neovim!!!
    Everything not on v0.12 is not supported with this config]])
end
