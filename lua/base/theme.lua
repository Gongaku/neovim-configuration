local is_work = require("helpers.sys-check").is_work
local colors = require("tokyonight.colors.night")
local options = {
  icons_enabled = not is_work,
  theme = {
    normal = {
      a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
      b = { fg = colors.green, bg = colors.bg_highlight },
      c = { fg = colors.fg }
    },
    insert = {
      a = { fg = colors.bg, bg = colors.blue5, gui = 'bold' },
      b = { fg = colors.blue5, bg = colors.bg_highlight },
    },
    visual = {
      a = { fg = colors.bg, bg = colors.orange, gui = 'bold' },
      b = { fg = colors.orange, bg = colors.bg_highlight },
    },
    replace = {
      a = { fg = colors.bg, bg = colors.red1, gui = 'bold' },
      b = { fg = colors.red, bg = colors.bg_highlight },
    },
    inactive = {
      a = { fg = colors.fg, bg = colors.bg, gui = 'bold' },
      b = { fg = colors.fg, bg = colors.bg },
      c = { fg = colors.fg, bg = colors.bg },
    },
  },
  disabled_filetypes = {
    "ministarter",
  },
}

require("lualine").setup({
  options = options,
  extensions = { "oil", "mason" },
})

-- Set theme
vim.cmd.colorscheme("tokyonight-night")
