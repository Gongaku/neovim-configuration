return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'bash', 'sh' },
  root_markers = { ".git" },
  settings = {
    bashIde = {
      logLevel = 'debug',
      globPattern = "*@(.sh|.inc|.bash|.command)",
      shfmt = {
        caseIndent = true,
        binaryNextLine = true,
        spaceRedirects = true
      },
    }
  }
}
