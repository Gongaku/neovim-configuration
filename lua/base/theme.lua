require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = 'powerline',
  },
  extensions = { "oil", "mason" },
})
vim.cmd.colorscheme("tokyonight-night")
