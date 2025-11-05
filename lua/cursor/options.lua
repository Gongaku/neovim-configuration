vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    if is_normal_buffer() then
      vim.b.updaterestore = vim.opt.updatetime:get()
      vim.opt.updatetime = 10000
    end
  end
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if is_normal_buffer() and vim.b.updatetime then
      vim.opt.updatetime = vim.b.updaterestore
      vim.b.updaterestore = nil
    end
  end
})
