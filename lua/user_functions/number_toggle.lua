--------------
-- Number Toggle
--------------
local augroup = vim.api.nvim_create_augroup("numbertoggle", {})

-- Automatically enable relative numbers when not in Insert Mode
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
  pattern = "*",
  group = augroup,
  callback = function()
    if vim.opt.number
        and vim.api.nvim_get_mode().mode ~= 'i' then
      vim.opt.relativenumber = true
    end
  end
})

-- Automatically disable relative numbers when in Insert Mode
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  pattern = "*",
  group = augroup,
  callback = function()
    if vim.opt.number then
      vim.opt.relativenumber = false
      if not vim.tbl_contains({ '@', '-' }, vim.v.event.cmdtype) then
        vim.cmd('redraw')
      end
    end
  end
})

