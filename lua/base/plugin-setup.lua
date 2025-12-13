---------------------
-- Mini Suite setup
---------------------
require("mini.pick").setup({
  mappings = { choose_marked = "<C-G>" },
  window = {
    config =
        function()
          local height = math.floor(0.85 * vim.o.lines)
          local width = math.floor(0.85 * vim.o.columns)
          return {
            anchor = 'NW',
            height = height,
            width = width,
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
          }
        end
  }
})
require("mini.extra").setup()
require("mini.completion").setup()

-- Snippet collection
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({ snippets = { require("mini.snippets").gen_loader.from_lang(), }, })
MiniSnippets.start_lsp_server()

-- Neovim start up page
local MiniStarter = require("mini.starter")
local version_build = "NVIM " .. vim.split(vim.fn.execute('version'), '\n')[2]:sub(6)
local new_section = function(name, action, section)
  return { name = name, action = action, section = section }
end
MiniStarter.setup({
  autoopen = true,
  evaluate_single = true,
  items = {
    new_section("Edit new buffer", ":enew", "Actions"),
    new_section("Open recent file", "lua require('mini.extra').pickers.oldfiles()", "Actions"),
    new_section("File Explorer", "lua require('oil')['open']()", "Actions"),
    new_section("Search text", ":Pick grep ", "Actions"),
    new_section("Quit Neovim", ":quitall!", "Actions"),
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
    MiniStarter.gen_hook.aligning("center", "center")
  },
  query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
  silent = false
})

---------------------
-- File Explorer
---------------------
oil = require("oil")

local is_detail_visible = false

oil.setup({
  view_options = { show_hidden = true, },
  keymaps = {
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        is_detail_visible = not is_detail_visible
        if is_detail_visible then
          oil.set_columns({ "permissions", "size", "mtime" })
        else
          oil.set_columns({})
        end
      end
    },
    ["<leader>:"] = {
      "actions.open_cmdline",
      opts = {
        shorten_path = true,
        modify = ":h",
      },
    },
  }
})
require("oil-git").setup({ highlights = { OilGitUntracked = { fg = "#ea0001" } } })

---------------------
-- Misc setup
---------------------
-- Write better shell scripts
require("shellcheck-nvim").setup()

-- Render Markdown elements within the terminal
require("render-markdown").setup({
  checkbox = {
    enabled = true,
    render_modes = false,
    bullet = false,
    right_pad = 1,
    unchecked = {
      icon = ' ',
      highlight = 'RenderMarkdownUnchecked',
      scope_highlight = nil,
    },
    checked = {
      icon = '󰱒 ',
      highlight = 'RenderMarkdownChecked',
      scope_highlight = nil,
    },
    custom = {
      todo = {
        raw = '[-]',
        rendered = '󰥔 ',
        highlight = 'RenderMarkdownTodo',
        scope_highlight = nil
      },
    },
  },
  completions = { lsp = { enabled = true } },
  heading = { border = true },
  indent = {
    enabled = true,
    skip_level = 0,
  },
  latex = { enabled = false },
  render_modes = true
})

-- Show tab lines
require("ibl").setup()

-- Automatically resize Neovim windows
-- using the golden ratio
require("focus").setup()

-- Syntax highlighting for different files
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c", "lua", "vim", "vimdoc", "javascript",
    "markdown", "markdown_inline", "html", "python",
  },
  sync_install = false,
  ignore_install = {},
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})
