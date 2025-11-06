if vim.version().minor >= 12 then
  vim.pack.add({
    -- File Explorer
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/benomahony/oil-git.nvim" },

    -- Mini suite
    -- Includes: Completion, Help Picker, and Snippets
    { src = "https://github.com/echasnovski/mini.nvim" },

    -- Language parsers
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", },

    -- Default configs for LSP servers
    { src = "https://github.com/neovim/nvim-lspconfig" },

    -- LSP servers
    { src = "https://github.com/mason-org/mason.nvim", },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },

    -- Snippets
    { src = "https://github.com/rafamadriz/friendly-snippets" },

    -- Render Markdown
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },

    -- Bash
    { src = "https://github.com/pablos123/shellcheck.nvim" },

    -- Color Theme
    { src = "https://github.com/folke/tokyonight.nvim" },

    -- Status line color theme
    { src = "https://github.com/nvim-lualine/lualine.nvim" },

    -- Show indentation lines
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },

    -- Typst preview and compilation
    { src = "https://github.com/chomosuke/typst-preview.nvim" }
  })
else
  require("base.lazy")
end
