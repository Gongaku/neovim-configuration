local M = {}

-- Count leading spaces in a line
local function count_indent(line)
	local spaces = line:match("^( *)")
	return spaces and #spaces or 0
end

function M.foldexpr(lnum)
	local line = vim.fn.getline(lnum)
	local next_line = vim.fn.getline(lnum + 1)

	-- Skip blank/empty lines
	if line:match("^%s*$") or line == "" then
		return "="
	end
	if next_line:match("^%s*$") or next_line == "" then
		return "="
	end

	local indent = count_indent(line)
	local next_indent = count_indent(next_line)

	-- Calculate levels (2-space indent)
	local level = math.floor(indent / 2)
	local next_level = math.floor(next_indent / 2)

	-- Open fold when next line more indented
	if next_indent > indent then
		return ">" .. (level + 1)
	end

	-- Close fold when less indented
	if next_indent < indent then
		return "<" .. (level + 1)
	end

	-- Same level
	return level
end

return M
