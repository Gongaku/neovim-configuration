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
}

if not helpers.is_work then
  table.insert(language_servers, "tinymist") -- Typst LSP

  -- For NixOS configurations only
  local is_nixos = helpers.file_contains("/etc/os-release", "nixos")
  if is_nixos then
    vim.lsp.enable("nixd") -- Nix Language LSP
  end
else
  -- table.insert(language_servers, "kube-linter") -- Helm/YAML Linter
  table.insert(language_servers, "yamlls") -- Helm/YAML Linter
end

require('mason').setup()
require('mason-lspconfig').setup({ ensure_installed = language_servers })

vim.lsp.enable(language_servers)

-- Enables a Lua language specific setting
-- Sets the workspace to allow for Lua LS support
-- for the Neovim configuration Lua files
vim.lsp.config("lua_ls", {
  settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true) } } }
})

-- Sets the autocomplete options to select from when using language servers
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup", "fuzzy" }
