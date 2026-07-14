if vim.version().minor < 12 then
	error("Neovim v0.12+ is required. Please update your Neovim installation.")
end

local plugins = {}
local repositories = {
	-- Misc
	"nvim-focus/focus.nvim", -- Change focus window size via the golden ratio
	-- File Explorer
	"stevearc/oil.nvim", -- File Explorer
	"benomahony/oil-git.nvim", -- Git Integration with File Explorer
	"echasnovski/mini.nvim", -- Mini suite: Includes completion, picker, and snippets
	-- Theming/Highlighting
	"folke/tokyonight.nvim", -- Tokyo Night Theme
	"nvim-lualine/lualine.nvim", -- Status line configuration
	"lukas-reineke/indent-blankline.nvim", -- Show indentations
	-- LSP
	"rafamadriz/friendly-snippets", -- Snippet collection for different languages
	"stevearc/conform.nvim", -- Formatter dispatch (stylua, etc)
	-- Markdown
	"MeanderingProgrammer/render-markdown.nvim", -- Render Markdown in terminal
	"YousefHadder/markdown-plus.nvim", -- Modern Markdown editing
}

-- For personal use plugins only
----------------------------------
if not helpers.is_work then
	repositories = {
		"chomosuke/typst-preview.nvim",
		unpack(repositories), -- Unpack other repositories table to combine tables
	}
end

local is_nixos = helpers.is_nixos
if not is_nixos then
	repositories = {
		"mason-org/mason.nvim", -- LSP repositories
		"mason-org/mason-lspconfig.nvim", -- Integration between mason and LSP config
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Install non-LSP tools (stylua, etc)
		unpack(repositories),
	}
end

for _, plugin in pairs(repositories) do
	table.insert(plugins, { src = "https://github.com/" .. plugin })
end

vim.pack.add(plugins)
