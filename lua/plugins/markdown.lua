require("render-markdown").setup({
  checkbox = {
    enabled = true,
    render_modes = true,
    bullet = false,
    right_pad = 1,
    unchecked = {
      icon = " ",
      highlight = "RenderMarkdownUnchecked",
      scope_highlight = nil,
    },
    checked = {
      icon = "󰱒 ",
      highlight = "RenderMarkdownChecked",
      scope_highlight = nil,
    },
    custom = {
      todo = {
        raw = "[-]",
        rendered = "󰥔 ",
        highlight = "RenderMarkdownTodo",
        scope_highlight = nil,
      },
    },
  },
  completions = { lsp = { enabled = true } },
  heading = { border = true },
  html = {
    enabled = true,
    comment = {
      conceal = true,
      text = nil,
      highlight = 'RenderMarkdownHtmlComment',
    },
  },
  indent = {
    enabled = true,
    per_level = 2,
    skip_level = 1,
  },
  inline_highlight = {
    enabled = true,
    highlight = 'RenderMarkdownInlineHighlight',
  },
  latex = { enabled = true },
  link = {
    enabled = true,
    footnote = {
      enabled = true,
      superscript = true
    },
    custom = {
      dnd = { pattern = "dnd.*.com", icon = '󱅕 ' },
    },
  },
  render_modes = true,
  sign = { enabled = false },
  yaml = { enabled = true },
})

require("markdown-plus").setup()
