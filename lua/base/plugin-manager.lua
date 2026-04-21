if vim.version().minor < 12 then
  error([[Please update to a newer version of neovim!!!
    Everything not on v0.12 is not supported with this config]])
end

local plugins = {}
local repositories = {
  -- Misc
  "nvim-focus/focus.nvim",                     -- Change focus window size via the golden ratio
  -- File Explorer
  "stevearc/oil.nvim",                         -- File Explorer
  "benomahony/oil-git.nvim",                   -- Git Integration with File Explorer
  "echasnovski/mini.nvim",                     -- Mini suite: Includes completion, picker, and snippets
  -- Theming/Highlighting
  "folke/tokyonight.nvim",                     -- Tokyo Night Theme
  "nvim-lualine/lualine.nvim",                 -- Status line configuration
  "lukas-reineke/indent-blankline.nvim",       -- Show indentations
  -- LSP
  "rafamadriz/friendly-snippets",              -- Snippet collection for different languages
  -- Markdown
  "MeanderingProgrammer/render-markdown.nvim", -- Render Markdown in terminal
  "YousefHadder/markdown-plus.nvim",           -- Modern Markdown editing
}

-- For personal use plugins only
----------------------------------
if not helpers.is_work then
  repositories = {
    "chomosuke/typst-preview.nvim",
    unpack(repositories), -- Unpack other repositories table to combine tables
  }
end

local is_nixos = helpers.file_contains("/etc/os-release", "nixos")
if not is_nixos then
  repositories = {
    "mason-org/mason.nvim",           -- LSP repositories
    "mason-org/mason-lspconfig.nvim", -- Integration between mason and LSP config
    unpack(repositories)
  }
end

for _, plugin in pairs(repositories) do
  table.insert(plugins, { src = "https://github.com/" .. plugin })
end

vim.pack.add(plugins)
