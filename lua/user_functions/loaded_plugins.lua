-- List Loaded Neovim plugins as a string to view in the :message buffer
local loaded_plugins = function()
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
