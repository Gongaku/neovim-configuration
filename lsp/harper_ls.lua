local dictionary_path = vim.fn.stdpath("config") .. "/lsp/harper_dictionary.txt"

return {
	cmd = { "harper-ls", "--stdio" },
	filetypes = {
		"asciidoc",
		"c",
		"cpp",
		"cs",
		"gitcommit",
		"go",
		"html",
		"java",
		"javascript",
		"lua",
		"markdown",
		"nix",
		"python",
		"ruby",
		"rust",
		"swift",
		"toml",
		"typescript",
		"typescriptreact",
		"haskell",
		"cmake",
		"typst",
		"php",
		"dart",
		"clojure",
		"sh",
	},
	root_markers = { ".git" },
	settings = {
		["harper-ls"] = {
			userDictPath = dictionary_path,
		},
	},
}
