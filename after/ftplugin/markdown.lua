vim.opt_local.textwidth = 80
vim.opt_local.wrap = true
vim.opt_local.linebreak = true -- wrap at word boundaries
vim.opt_local.breakindent = true -- preserve indent on wrapped lines
vim.opt_local.formatoptions:append("t") -- auto-wrap at textwidth while typing
vim.opt_local.formatoptions:append("n") -- recognize numbered lists
vim.opt_local.formatoptions:remove("l") -- wrap already-long lines too
