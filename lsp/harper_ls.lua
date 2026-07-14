local dictionary_path = vim.fn.stdpath("config") .. "/lsp/harper_dictionary.txt"

return {
	cmd = { "harper-ls", "--stdio" },
	filetypes = {
		-- keep-sorted start
		"asciidoc",
		"c",
		"clojure",
		"cmake",
		"cpp",
		"cs",
		"dart",
		"gitcommit",
		"go",
		"haskell",
		"html",
		"java",
		"javascript",
		"lua",
		"mail",
		"markdown",
		"nix",
		"org",
		"php",
		"plaintex",
		"python",
		"ruby",
		"rust",
		"scala",
		"sh",
		"swift",
		"tex",
		"text",
		"toml",
		"typescript",
		"typescriptreact",
		"typst",
		"zig",
		-- keep-sorted end
	},
	root_markers = { ".git" },
	settings = {
		["harper-ls"] = {
			markdown = {
				IgnoreLinkTitle = true,
			},
			userDictPath = dictionary_path,
		},
	},
}
