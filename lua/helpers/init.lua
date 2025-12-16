local M = {}

M.file_contains = function(filename, string)
  local file_buffer = io.open(filename, 'r')
  local contains_string = nil
  if file_buffer then
    local file_contents = file_buffer:read("*a")
    file_buffer:close()
    file_contents = file_contents:lower()
    contains_string = file_contents:match(string)
  end
  return contains_string
end

M.package_installed = function(package_name)
  local is_installed = false
  for _, v in pairs(vim.pack.get()) do
    if v.active
        and v.spec.name == package_name then
      is_installed = true
    end
  end
  return is_installed
end

M.operating_system = tostring(vim.loop.os_uname().sysname)
M.is_work = string.find(M.operating_system, "macunix") ~= nil and true or false

return M
