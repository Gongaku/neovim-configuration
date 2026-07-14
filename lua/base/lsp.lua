-- Table/list of language servers to install/download
-- This initial list is for all environments,
-- while other inserts are either environment specific or are
-- not valid names for `mason-lspconfig` but are installed via other means
local language_servers = {
	-- keep-sorted start
	"bashls", -- Bash LS
	"harper_ls", -- Multilanguage Linter
	"lua_ls", -- Lua LS
	"pyright", -- Python Linter
	"ruff", -- Python LS
	"yamlls", -- YAML Linter
	-- keep-sorted end
}

-- For NixOS configurations only
local is_nixos = helpers.is_nixos
if is_nixos then
	table.insert(language_servers, "nixd") -- Nix Language LSP
else
	-- Non-NixOS configurations utilize Mason LSP config to install LSPs
	require("mason").setup()
	require("mason-lspconfig").setup({ ensure_installed = language_servers })
	require("mason-tool-installer").setup({ ensure_installed = { "stylua" } })
end
vim.lsp.enable(language_servers)

-- Sets the autocomplete options to select from when using language servers
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup", "fuzzy" }
