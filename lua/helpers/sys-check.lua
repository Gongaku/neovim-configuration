local M = {}

local file_contains = function(filename, string)
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
local operating_system = tostring(vim.loop.os_uname().sysname)
local is_work = string.find(operating_system, "macunix")

M.file_contains = file_contains
M.operating_system = operating_system
M.is_work = is_work

return M
