local map = vim.keymap.set -- Key Mappings

map({ "n", "v", "o" }, "<leader>r", ':update<CR> :source $MYVIMRC<CR> :echo "Reloaded Neovim"<CR>')
map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>q", ":quitall!<CR>", { desc = "Quit file" })
map("n", "<leader>s", ":saveas ", { desc = "Save file as" })

-- Terminal Mappings
map({ "t" }, "<leader>q", "<C-\\><C-n>", { desc = "Quit Terminal" })

-- Buffers Keymap
map("n", "<C-W>%", ":vsplit<CR>", { desc = "Split Vertically" })
map("n", '<C-W>"', ":split<CR>", { desc = "Split Horizontally" })
map("n", "<leader>tn", ":tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>fn", ":enew<CR>", { desc = "Open new file" })
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>ls", MiniPick.builtin.buffers, { desc = "Search buffers" })

-- Mini Pick Plugin Keymap
-- `./help.lua` and `../plugin/mini.lua`
map("n", "<leader>pf", function() MiniPick.builtin.files({ tool = "fd" }) end, { desc = "Search Files" })
map("n", "<leader>pg", MiniPick.builtin.grep_live, { desc = "Search Grep Pattern" })
map("n", "<leader>pn", MiniExtra.pickers.history, { desc = "Search History" })
map("n", "<leader>ph", MiniPick.builtin.help, { desc = "Search Help files" })
map("n", "<leader>pm", MiniExtra.pickers.keymaps, { desc = "Search Key Mappings" })

-- LSP Plugin Keymap
-- `./lsp.lua` and `../plugin/lsp-plugins.lua`
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })
map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Get definition" })
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Get implementation" })
map("n", "<leader>gr", vim.lsp.buf.references, { desc = "Get references" })
map("i", "<C-e>", vim.lsp.completion.get, { desc = "Get completion" })
map("n", "<leader>pd", MiniExtra.pickers.diagnostic, { desc = "Open Diagnostics" })

-- Toggle File Explorer
if package.loaded["oil"] then
  -- If oil is loaded
  map("n", "<leader>e", function()
    assert(require("oil")[vim.bo.filetype == "oil" and "close" or "open"])()
  end, { desc = "Open File Explorer" })
else
  -- Default to `netrw` (network read write) file explorer if neither are loaded
  map("n", "<leader>e", function()
    vim.cmd(vim.bo.filetype == "netrw" and ":Rex" or ":Ex")
  end, { desc = "Open File Explorer" })
end
