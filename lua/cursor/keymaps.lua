local keymap = vim.keymap.set
local opts = {
	noremap = true,
	silent = true,
}

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap({ "n", "v" }, "<leader>y", '"+y', opts)
keymap({ "n", "v" }, "<leader>p", '"+p', opts)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)
keymap({ "n", "v" }, "<leader>ex", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')")
