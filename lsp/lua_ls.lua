return {
	cmd = { "lua-language-server", "--logpath", "/tmp" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			completion = {
				enable = true,
			},
			diagnostics = { globals = { "vim", "helpers" } },
			workspace = {
				preloadFileSize = 10000,
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
