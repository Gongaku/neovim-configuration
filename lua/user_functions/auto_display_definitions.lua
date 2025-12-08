-- Show code definition/issues on hover
vim.cmd([[
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
]])
