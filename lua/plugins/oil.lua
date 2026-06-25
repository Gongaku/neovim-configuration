local oil = require("oil")
local is_detail_visible = false

oil.setup({
  view_options = { show_hidden = true },
  keymaps = {
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        is_detail_visible = not is_detail_visible
        oil.set_columns(is_detail_visible and { "permissions", "size", "mtime" } or {})
      end,
    },
    ["<leader>:"] = {
      "actions.open_cmdline",
      opts = {
        shorten_path = true,
        modify = ":h",
      },
    },
  },
})
require("oil-git").setup({
  highlights = {
    OilGitUntracked = { fg = "#ea0001" }
  }
})
