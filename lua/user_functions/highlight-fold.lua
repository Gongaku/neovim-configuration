vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = args.match
    local excluded_fts = function()
      local excluded = {
        "lua",
      }

      for _, filetype in pairs(excluded) do
        if ft == filetype then
          return true
        end
      end
      return false
    end

    if not excluded_fts() then
      require("mini.indentscope").setup({
        draw = {
          delay = 50,
          animation = function() return 0 end,
        },
        symbol = "▎",
      })
    end
  end,
})
