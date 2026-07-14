-- Set vim options
vim.opt.number = true -- Line number display
vim.opt.relativenumber = true -- Relative number display from current line
vim.opt.signcolumn = "yes" -- Extra column to left for signs/symbols
vim.opt.autoindent = true -- Auto-indentation
vim.opt.shiftwidth = 2 -- Set number of spaces for auto-indentation
vim.opt.tabstop = 2 -- Set tab length
vim.opt.softtabstop = 2 -- Backspace removes up to 2 spaces
vim.opt.expandtab = true
vim.opt.laststatus = 3 -- Changes when last window will have a status line
vim.opt.termguicolors = true -- 24-bit RGB color in the TUI
vim.opt.winborder = "rounded" -- Adds border to hover text box
vim.opt.foldenable = false -- Disable folding on startup
vim.opt.foldlevel = 20 -- Prevent auto-folding upon manual folding ("zc", "za", etc.)
vim.opt.scrolloff = 4 -- Ensures that 4 lines are visible when scrolling vertically
vim.opt.sidescrolloff = 4 -- Ensures that 4 lines are visible when scrolling horizontally
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all yank/delete/paste operations
vim.opt.undofile = true -- Enables persistent undo history
vim.g.mapleader = " " -- Changes vim starting shortcut key

-- Vim Network Read Write File Explorer
vim.g.loaded_netrw = 1 -- Disables Vim File Explorer
vim.g.loaded_netrwPlugin = 1 -- Disables Vim File Explorer Plugin

-- Designates where to install nvim plugins
local data_home = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
local package_path = vim.fn.expand(data_home .. "/nvim/site/pack")
vim.opt.packpath:prepend(package_path)

-- Diagnostics
vim.diagnostic.config({
	virtual_text = false, -- disable inline text (reduces noise)
	signs = true,
	underline = true,
	float = {
		border = "rounded",
		source = true, -- show which LSP reported diagnostic
	},
})
vim.diagnostic.enable() -- Enable diagnostic text
vim.opt.updatetime = 250 -- Millisecond wait of no activity before write swap to disk

-- Set theme
local theme_installed = function(package, theme_name)
	if helpers.package_installed(package) then
		return theme_name
	end
	return nil
end

local theme = theme_installed("tokyonight.nvim", "tokyonight-night")
	or theme_installed("catppuccin.nvim", "catppuccin")
	or "wildcharm"
vim.cmd.colorscheme(theme)
