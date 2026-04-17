local hostname = vim.uv.os_gethostname()

return {
  cmd = { "nixd" },
  filetypes = { "nix" },
  -- root_markers = { "flake.nix", ".git" },
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
          expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations."
              .. hostname
              .. ".options",
        },
        home_manager = {
          expr = "(builtins.getFlake (builtins.toString ./.)).homeConfigurations."
              .. hostname
              .. ".options",
        },
      },
    },
  },
}
