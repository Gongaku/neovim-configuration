if vim.g.vscode then
  require("cursor")
else
  require("base.vim-options")
  require("base.plugin-manager")
  require("base.plugin-setup")
  require("base.theme")
  require("base.lsp")
  require("base.keymappings")
  require("user_functions")
end
