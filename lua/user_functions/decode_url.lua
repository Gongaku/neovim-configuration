-- Convert URL characters into original characters
-- Ex: %20 -> [Space]
local DecodeUrl = function()
  vim.cmd([[:%s/%\(\x\x\)/\=iconv(nr2char('0x' .. submatch(1)), 'utf-8', 'latin1')/ge]])
  vim.notify("Decoded Url")
end

vim.api.nvim_create_user_command("DecodeUrl", DecodeUrl, {
  nargs = 0,
  desc = "Decode URI to Human-readable characters"
})
