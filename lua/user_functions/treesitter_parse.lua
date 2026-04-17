-- Automatically detect the fold method based on
-- the treesitter parsers
vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function()
		if pcall(vim.treesitter.get_parser, 0) then
			vim.opt_local.foldmethod = "expr"
			vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.opt_local.foldcolumn = "0"
			vim.opt_local.foldtext = ""
			vim.opt_local.foldlevel = 99
			-- vim.opt_local.foldlevelstart = 1
			-- vim.opt_local.foldnestmax = 4
		else
			vim.opt_local.foldmethod = "syntax"
		end
	end,
})
