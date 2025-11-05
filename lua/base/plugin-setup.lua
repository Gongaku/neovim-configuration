-- Mini Suite setup
require("mini.pick").setup({
  mappings = {
    choose_marked = "<C-G>"
  }
})
require("mini.snippets").setup({
  snippets = {
    require("mini.snippets").gen_loader.from_lang(),
  },
})
require("mini.snippets").start_lsp_server()

require("mini.completion").setup()

-- File Explorer
require("oil").setup({
  view_options = {
    show_hidden = true,
  }
})
require("oil-git").setup({
  highlights = {
    OilGitUntracked = { fg = "#ea0001" }
  }
})

-- Misc setup
require("shellcheck-nvim").setup()
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
require("ibl").setup()
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c", "lua", "vim", "vimdoc", "elixir", "javascript",
    "markdown", "markdown_inline", "html", "python",
  },
  sync_install = false,
  ignore_install = {},
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})
