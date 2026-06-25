require("mini.pick").setup({
  window = {
    config = function()
      local height = math.floor(0.9 * vim.o.lines)
      local width = math.floor(1 * vim.o.columns)
      return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.2 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
})
require("mini.extra").setup()
require("mini.completion").setup()
require("mini.cmdline").setup()
require("mini.indentscope").setup({
  draw = {
    delay = 50,
    animation = function() return 0 end,
  },
  symbol = "▎",
})

if string.find(tostring(os.getenv("TERM")), "kitty")
    or os.getenv("TERM") == "foot" then
  require("mini.icons").setup()
end

local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
  snippets = {
    require("mini.snippets").gen_loader.from_lang(),
  },
})
MiniSnippets.start_lsp_server()

if not helpers.is_work then
  local MiniStarter = require("mini.starter")
  local version_build = "NVIM " .. vim.split(vim.fn.execute("version"), "\n")[2]:sub(6)

  local starter_section = function(name, action, section)
    return { name = name, action = action, section = section }
  end

  MiniStarter.setup({
    autoopen = true,
    evaluate_single = true,
    items = {
      starter_section("Edit new buffer", ":enew", "Actions"),
      starter_section("Open recent file", "lua require('mini.extra').pickers.oldfiles()", "Actions"),
      starter_section("File Explorer", "lua require('oil')['open']()", "Actions"),
      starter_section("Search text", ":Pick grep ", "Actions"),
      starter_section("Quit Neovim", ":quitall", "Actions"),
      MiniStarter.sections.recent_files(5, false),
    },
    header = table.concat({
      [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
      [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
      [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
      [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
      [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
      [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      [[]],
      string.rep(" ", 22) .. version_build,
    }, "\n"),
    footer = "",
    content_hooks = {
      MiniStarter.gen_hook.adding_bullet("- "),
      MiniStarter.gen_hook.aligning("center", "center"),
    },
    query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",
    silent = true,
  })
end
