-- List Loaded Neovim plugins as a string to view in the :message buffer
-- Scans 'runtimepath' rather than vim.pack.get(), which misses plugins Nix puts on 'packpath'
local loaded_plugins = function()
	for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
		-- vim.pack: pack/core/opt/<name>; home-manager / nix run: pack/<x>/start/<name>
		local name = path:match("/pack/[^/]+/[^/]+/([^/]+)$")
		-- Skip Neovim's bundled packages (e.g. matchit)
		if name and not vim.startswith(path, vim.env.VIMRUNTIME) then
			print(name)
		end
	end
end
vim.api.nvim_create_user_command("LoadedPlugins", loaded_plugins, {
	nargs = 0,
	desc = "Get loaded packages",
})
