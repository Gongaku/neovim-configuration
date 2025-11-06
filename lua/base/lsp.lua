local lsp_list = {
  "lua_ls",    -- Lua
  "bashls",    -- Bash
  "pyright",   -- Python
  "harper_ls", -- Linter & multi-language
  "tinymist"   -- Typst
}

local fd_os_release = assert(io.open("/etc/os-release"), "r")
local s_os_release = fd_os_release:read("*a")
fd_os_release:close()
s_os_release = s_os_release:lower()
local is_nixos = s_os_release:match("nixos")

if is_nixos == nil then
	require('mason').setup()
	require('mason-lspconfig').setup({ ensure_installed = lsp_list })
end

vim.lsp.enable(lsp_list)

vim.lsp.config("lua_ls", {
  settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true) } } }
})

vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup", "fuzzy" }

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(event)
-- 		local client = vim.lsp.get_client_by_id(event.data.client_id)
-- 		if not client then return end
--
-- 	  if client:supports_method('textDocument/completion') then
-- 			vim.lsp.completion.enable(true, client.id, event.buf, {
-- 				autotrigger = true,
-- 				convert = function(item)
-- 					return { abbr = item.label:gsub("%b()", "") }
-- 				end,
-- 			})
-- 		end
--
-- 		if client:supports_method('textDocument/inlayHint') then
-- 			vim.lsp.inlay_hint.enable(true, {bufnr = event.buf})
-- 		end
-- 	end
-- })
