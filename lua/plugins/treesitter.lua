if helpers.is_nixos then
	-- NixOS ships the parsers via home-manager (nix/home-manager.nix)
	return
end

require("nvim-treesitter.configs").setup({
	ensure_installed = { "html", "yaml", "typst" },
	sync_install = false,
	auto_install = false,
	highlight = { enable = false },
	indent = { enable = false },
	incremental_selection = { enable = false },
})
