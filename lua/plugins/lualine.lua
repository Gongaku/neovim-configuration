local set_theme = function()
  if vim.g.colors_name == "tokyonight-night" then
    local colors = require("tokyonight.colors.night")
    local section_colors = function(color)
      return {
        a = { fg = colors.bg, bg = colors[color], gui = "bold" },
        b = { fg = colors[color], bg = colors.bg_highlight },
        c = { fg = colors[color] },
      }
    end
    return {
      normal = section_colors("green"),
      insert = section_colors("blue2"),
      visual = section_colors("orange"),
      replace = section_colors("red1"),
      inactive = section_colors("fg"),
    }
  else
    return "auto"
  end
end

require("lualine").setup({
  options = {
    icons_enabled = not helpers.is_work,
    theme = set_theme(),
    disabled_filetypes = {
      "checkhealth",
      "nvim-pack",
      "ministarter",
    },
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  extensions = { "oil", "mason" },
})
