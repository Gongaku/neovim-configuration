return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'py', "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  -- settings = {
  -- },
}
