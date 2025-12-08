-- Source helper function
local sys_check = require("helpers.sys-check")

-- Table/list of language servers to install/download
-- This initial list is for all environments,
-- while other inserts are either environment specific or are
-- not valid names for mason-lspconfig but are installed via other means
local language_servers = {
  "lua_ls",    -- Lua LS
  "bashls",    -- Bash LS
  "ruff",      -- Python LS
  "pyright",   -- Python Linter
  "harper_ls", -- Linter & multi-language
}

if not sys_check.is_work then
  table.insert(language_servers, "tinymist")    -- Typst LSP
else
  table.insert(language_servers, "kube-linter") -- Helm/YAML Linter
end

require('mason').setup()
require('mason-lspconfig').setup({ ensure_installed = language_servers })

if not sys_check.is_work then
  -- For NixOS configurations only
  local is_nixos = sys_check.file_contains("/etc/os-release", "nixos")
  if is_nixos then
    -- table.insert(language_servers, "nil_ls")
    vim.lsp.enable("nixd")
  end
end

vim.lsp.enable(language_servers)

-- Enables a Lua language specific setting
-- Sets the workspace to allow for Lua LS support
-- for the Neovim configuration Lua files
vim.lsp.config("lua_ls", {
  settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true) } } }
})

-- Sets the auto complete options to select from when using language servers
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup", "fuzzy" }
