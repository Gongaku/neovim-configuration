-- Table/list of language servers to install/download
-- This initial list is for all environments,
-- while other inserts are either environment specific or are
-- not valid names for `mason-lspconfig` but are installed via other means
local language_servers = {
  "lua_ls",    -- Lua LS
  "bashls",    -- Bash LS
  "ruff",      -- Python LS
  "pyright",   -- Python Linter
  "harper_ls", -- Multilanguage Linter
  "yamlls",    -- YAML Linter
}

-- For NixOS configurations only
local is_nixos = helpers.is_nixos
if is_nixos then
  table.insert(language_servers, "nixd") -- Nix Language LSP
else
  -- Non-NixOS configurations utilize Mason LSP config to install LSPs
  require("mason").setup()
  require("mason-lspconfig").setup({ ensure_installed = language_servers })
end
vim.lsp.enable(language_servers)

-- Sets the autocomplete options to select from when using language servers
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup", "fuzzy" }
