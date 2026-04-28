local EXCLUDED = { lua = true }

-- vim.api.nvim_create_autocmd("FileType", {
--   callback = function(args)
--     vim.b[args.buf].miniindentscope_disable = EXCLUDED[args.match] or false
--     print(args.match)
--     print(vim.b[args.buf].miniindentscope_disable)
--   end,
-- })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function(args)
    vim.b[args.buf].miniindentscope_disable = true
  end
})
