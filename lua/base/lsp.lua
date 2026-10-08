-- Table/list of language servers to install/download
-- This initial list is for all environments,
-- while other inserts are either environment specific or are
-- not valid names for `mason-tool-installer` but are installed via other means
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

-- Mason package names for the servers in `language_servers`.
-- `mason-tool-installer` expects Mason registry names, not lspconfig server names.
local mason_packages = {
	-- keep-sorted start
	"bash-language-server", -- Bash LS
	"harper-ls", -- Multilanguage Linter
	"lua-language-server", -- Lua LS
	"pyright", -- Python Linter
	"ruff", -- Python LS
	"stylua", -- Lua Formatter
	"yaml-language-server", -- YAML Linter
	-- keep-sorted end
}

-- For NixOS configurations only
local is_nixos = helpers.is_nixos
if is_nixos then
	table.insert(language_servers, "nixd") -- Nix Language LSP
else
	-- Non-NixOS configurations utilize Mason to install LSPs and other tools
	require("mason").setup()
	require("mason-tool-installer").setup({ ensure_installed = mason_packages })
end
vim.lsp.enable(language_servers)

-- Sets the autocomplete options to select from when using language servers
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup", "fuzzy" }
