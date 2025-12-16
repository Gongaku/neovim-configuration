---------------------
-- Mini Suite setup
---------------------
-- Picks anything
require("mini.pick").setup({
  mappings = { choose_marked = "<C-G>" },
  window = {
    config = function()
      local height = math.floor(0.85 * vim.o.lines)
      local width = math.floor(0.85 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width))
      }
    end
  }
})
require("mini.extra").setup()      -- Adds additional features to all mini plugins
require("mini.completion").setup() -- Enables IDE autocompletions

-- Snippet collection
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
  snippets = {
    require("mini.snippets").gen_loader.from_lang(),
  },
})
MiniSnippets.start_lsp_server()

-- Neovim start up page
local MiniStarter = require("mini.starter")
local version_build = "NVIM " .. vim.split(vim.fn.execute('version'), '\n')[2]:sub(6)

if not helpers.is_work then
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
      MiniStarter.gen_hook.aligning("center", "center")
    },
    query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
    -- silent = false
    silent = true
  })
end

---------------------
-- File Explorer
---------------------
local oil = require("oil")
local is_detail_visible = false

oil.setup({
  view_options = { show_hidden = true, },
  keymaps = {
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        is_detail_visible = not is_detail_visible
        oil.set_columns(is_detail_visible and { "permissions", "size", "mtime" } or {})
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
-- Markdown
---------------------
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

---------------------
-- Status Line Theming
---------------------
-- Color scheme
local set_theme = function()
  if vim.g.colors_name == "tokyonight-night" then
    local colors = require("tokyonight.colors.night")
    -- Dynamically set colors of section
    local section_colors = function(color)
      return {
        a = { fg = colors.bg, bg = colors[color], gui = 'bold' },
        b = { fg = colors[color], bg = colors.bg_highlight },
        c = { fg = colors[color] }
      }
    end
    return {
      normal = section_colors("green"),
      insert = section_colors("blue2"),
      visual = section_colors("orange"),
      replace = section_colors("red1"),
      inactive = section_colors("fg")
    }
  else
    return 'auto'
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
    -- Change separators into diagonal lines instead of sideways triangles
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  extensions = { "oil", "mason" },
})

---------------------
-- Misc setup
---------------------
-- Write better shell scripts
require("shellcheck-nvim").setup()

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
