if vim.version().minor >= 12 then
  local plugins = {
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

    -- Neovim focus
    { src = "https://github.com/nvim-focus/focus.nvim" },
  }

  local is_work = require("helpers.sys-check").is_work

  if not is_work then
    local additional_plugins = {
      -- Typst preview and compilation
      { src = "https://github.com/chomosuke/typst-preview.nvim" }
    }

    for _, plugin in pairs(additional_plugins) do
      table.insert(plugins, plugin)
    end
  end

  vim.pack.add(plugins)
else
  print()
  print("Please update to a newer version of neovim!!!")
  print("Everything not on v0.12 is not supported with this config")
  -- require("base.lazy")
end
