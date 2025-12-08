function getHostname()
  local f = io.popen("hostname")
  local hostname = f:read("*a") or nil
  f:close()
  return string.gsub(hostname, "\n$", "")
end

return {
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixfmt" },
      },
      options = {
        nixos = {
          expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations." .. getHostname() .. ".options",
        },
        home_manager = {
          expr = "(builtins.getFlake (builtins.toString ./.)).homeConfigurations." .. getHostname() .. ".options"
        },
      },
    },
  },
}
