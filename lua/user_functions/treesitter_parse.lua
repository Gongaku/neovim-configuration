-- Automatically detect the fold method based on
-- the treesitter parsers
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    if require("nvim-treesitter.parsers").has_parser() then
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldcolumn = "0"
      vim.opt.foldtext = ""
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 1
      vim.opt.foldnestmax = 4
    else
      vim.opt.foldmethod = "syntax"
    end
  end
})
