-- Set vim options
vim.opt.number = true             -- Line number display
vim.opt.relativenumber = true     -- Relative number display from current line
vim.opt.signcolumn = 'yes'        -- Extra column to left for signs/symbols
vim.opt.autoindent = true         -- Auto-indentation
vim.opt.shiftwidth = 2            -- Set number of spaces for auto-indentation
vim.opt.tabstop = 2               -- Set tab length
vim.opt.laststatus = 3            -- Changes when last window will have a status line
vim.opt.termguicolors = true      -- 24-bit RGB color in the TUI
vim.opt.winborder = "rounded"     -- Adds border to hover text box
vim.opt.foldenable = false        -- Disable folding on startup
vim.opt.foldlevel = 20            -- Prevent auto-folding upon manual folding ("zc", "za", etc.)

vim.g.mapleader = " "             -- Changes vim starting shortcut key

-- Vim Network Read Write File Explorer
vim.g.loaded_netrw = 1            -- Disables Vim File Explorer
vim.g.loaded_netrwPlugin = 1      -- Disables Vim File Explorer Plugin

-- Designates where to install vim.pack plugins
vim.opt.packpath:prepend(vim.fn.expand("$XDG_DATA_HOME/nvim/site/pack"))

-- Diagnostics
vim.diagnostic.enable = true      -- Enable diagnostic text
vim.opt.updatetime = 250          -- Millisecond wait of no activity before write swap to disk

-- -- Show code definition/issues on hover
-- vim.cmd([[
--   autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
-- ]])

--------------
-- Number Toggle
--------------
local augroup = vim.api.nvim_create_augroup("numbertoggle", {})

-- Automatically enable relative numbers when not in Insert Mode
vim.api.nvim_create_autocmd({'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter'}, {
  pattern = "*",
  group = augroup,
  callback = function()
    if vim.opt.number and vim.api.nvim_get_mode().mode ~= 'i' then
      vim.opt.relativenumber = true
    end
  end
})

-- Automatically disable relative numbers when in Insert Mode
vim.api.nvim_create_autocmd({'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave'}, {
  pattern = "*",
  group = augroup,
  callback = function()
    if vim.opt.number then
      vim.opt.relativenumber = false
      if not vim.tbl_contains({'@', '-'}, vim.v.event.cmdtype) then
        vim.cmd('redraw')
      end
    end
  end
})

-- Automatically remove trailing spaces on write
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function()
		if require("nvim-treesitter.parsers").has_parser() then
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		else
			vim.opt.foldmethod = "syntax"
		end
	end
})

-- Convert URL characters into original characters
-- Ex: %20 -> [Space]
local DecodeUrl = function()
	vim.cmd([[:%s/%\(\x\x\)/\=iconv(nr2char('0x' .. submatch(1)), 'utf-8', 'latin1')/ge]])
	vim.notify("Decoded Url")
end

vim.api.nvim_create_user_command("DecodeUrl", DecodeUrl, {
	nargs = 0,
	desc = "Decode URI to Human-readable characters"
})

local loaded_plugins = function ( )
  if vim.version().minor >= 12 then
    local plugin_list = vim.pack.get()
    for _, v in pairs(plugin_list) do
      if v.active then
        print(v.spec.name)
      end
    end
  else
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
      local plug = path:match("(lazy.*)")
      if plug ~= nil then
        local _, plugin = plug:match("(/)(.*)")
        if plugin ~= "readme" and not plugin:match("(.*)(/after)") then
          print(plugin)
        end
      end
    end
  end
end
vim.api.nvim_create_user_command("LoadedPlugins", loaded_plugins, {
  nargs = 0,
  desc = "Get loaded packages"
})
