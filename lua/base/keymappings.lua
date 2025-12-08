local map = vim.keymap.set -- Key Mappings

map({ 'n', 'v' }, '<leader>r', ':update<CR> :source<CR> :echo "Reloaded Neovim"<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map('n', '<leader>s', ':saveas ')

-- Terminal Mappings
map({ 't' }, '<leader>q', '<C-\\><C-n>')

-- Buffers Keymap
map('n', '<C-W>%', ':vsplit<CR>')
map('n', '<C-W>"', ':split<CR>')
map('n', '<leader>tn', ':tabnew<CR>')
map('n', '<leader>fn', ':enew<CR>')
map('n', '<leader>bn', ':bnext<CR>')
map('n', '<leader>bp', ':bprevious<CR>')
map('n', '<leader>bd', ':bdelete<CR>')
-- map('n', '<leader>ls', ':buffers<CR>')
map('n', '<leader>ls', ':Pick buffers<CR>')

-- Clipboard Keymap
map({ 'n', 'v' }, 'y', '"+y') -- Send yank to system clipboard register
map({ 'n', 'v' }, 'p', '"+p') -- Paste from system clipboard register
map({ 'n', 'v' }, 'd', '"+d') -- Paste from system clipboard register

-- Mini Pick Plugin Keymap
-- `./help.lua` and `../plugin/mini.lua`
map('n', '<leader>f', ':Pick files<CR>')
map('n', '<leader>g', ':Pick grep<CR>')
map('n', '<leader>t', ':Pick history<CR>')
map('n', '<leader>h', ':Pick help<CR>')
map('n', '<leader>b', ":Pick keymaps<CR>") -- Show all keymaps

-- LSP Plugin Keymap
-- `./lsp.lua` and `../plugin/lsp-plugins.lua`
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>gd', vim.lsp.buf.definition)
map('n', '<leader>gi', vim.lsp.buf.implementation)
map('n', '<leader>gr', vim.lsp.buf.references)
map('i', '<C-e>', vim.lsp.completion.get)
-- map('n', '<leader>d', vim.diagnostic.setqflist)
map('n', '<leader>d', ':Pick diagnostic scope="current"<CR>')

-- Toggle File Explorer
if package.loaded['oil'] then
  -- If oil is loaded
  map('n', '<leader>e', function()
    assert(require('oil')[vim.bo.filetype == 'oil' and "close" or "open"])()
  end)
elseif package.loaded['nvim-tree'] then
  -- If the Neovim tree module is loaded
  map({ 'n', 'v', 'o' }, '<leader>e', ':NvimTreeToggle<CR>')
else
  -- Default to `netrw` (network read write) file explorer if neither are loaded
  map('n', '<leader>e', function() vim.cmd(vim.bo.filetype == 'netrw' and ":Rex" or ":Ex") end)
end
