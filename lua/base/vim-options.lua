-- Set vim options
vim.opt.number = true         -- Line number display
vim.opt.relativenumber = true -- Relative number display from current line
vim.opt.signcolumn = 'yes'    -- Extra column to left for signs/symbols
vim.opt.autoindent = true     -- Auto-indentation
vim.opt.shiftwidth = 2        -- Set number of spaces for auto-indentation
vim.opt.tabstop = 2           -- Set tab length
vim.opt.laststatus = 3        -- Changes when last window will have a status line
vim.opt.termguicolors = true  -- 24-bit RGB color in the TUI
vim.opt.winborder = "rounded" -- Adds border to hover text box
vim.opt.foldenable = false    -- Disable folding on startup
-- vim.opt.foldlevel = 20        -- Prevent auto-folding upon manual folding ("zc", "za", etc.)

vim.g.mapleader = " "         -- Changes vim starting shortcut key

-- Vim Network Read Write File Explorer
vim.g.loaded_netrw = 1       -- Disables Vim File Explorer
vim.g.loaded_netrwPlugin = 1 -- Disables Vim File Explorer Plugin

-- Designates where to install nvim plugins
vim.opt.packpath:prepend(vim.fn.expand("${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack"))

-- Diagnostics
vim.diagnostic.enable = true -- Enable diagnostic text
vim.opt.updatetime = 250     -- Millisecond wait of no activity before write swap to disk

-- Set theme
local theme = helpers.package_installed("tokyonight.nvim") and "tokyonight-night" or "wildcharm"
vim.cmd.colorscheme(theme)
