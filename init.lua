if vim.g.vscode then
  require("cursor")
else
  -- Helper functions
  _G.helpers = require("helpers")

  require("base.plugin-manager")
  require("base.vim-options")
  require("base.plugin-setup")
  require("base.lsp")
  require("base.keymappings")
  require("user_functions")
end
