local M = {}

M.file_contains = function(filename, string)
  local file_buffer = io.open(filename, "r")
  local contains_string = nil
  if file_buffer then
    local file_contents = file_buffer:read("*a")
    file_buffer:close()
    file_contents = file_contents:lower()
    contains_string = file_contents:match(string)
  end
  return contains_string ~= nil
end

M.package_installed = function(package_name)
  local ok, packs = pcall(vim.pack.get)
  if not ok then return false end
  for _, v in pairs(packs) do
    if v.active and v.spec.name == package_name then
      return true
    end
  end
  return false
end

M.operating_system = tostring(vim.uv.os_uname().sysname)
M.is_work = string.find(M.operating_system, "Darwin") ~= nil
M.is_nixos = M.file_contains("/etc/os-release", "nixos")

return M
