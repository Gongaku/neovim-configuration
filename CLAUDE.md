# CLAUDE.md — Neovim Configuration Architecture

## Module Load Order

`init.lua` is the entry point. It branches on `vim.g.vscode`:

- **VS Code / Cursor**: loads `lua/cursor/` only (minimal keymaps + options)
- **Normal Neovim**: loads in order:
  1. `lua/helpers/init.lua` → exposed as `_G.helpers` (available everywhere)
  2. `lua/base/plugin-manager.lua` → registers plugins via `vim.pack`
  3. `lua/base/vim-options.lua` → sets global Vim options and colorscheme
  4. `lua/base/plugin-setup.lua` → configures each plugin
  5. `lua/base/lsp.lua` → enables LSP servers
  6. `lua/base/keymappings.lua` → defines all keymaps
  7. `lua/user_functions/init.lua` → loads user-defined autocommands/utilities

## Adding a Plugin

1. Add the GitHub path (`"owner/repo"`) to the `repositories` table in `lua/base/plugin-manager.lua`
2. Add its setup call in `lua/base/plugin-setup.lua`
3. Run Neovim once — `vim.pack` fetches and records the revision in `nvim-pack-lock.json`
4. Run `./sync-pack-revs.sh` to sync the revision into `nix-nvim-pack-lock.json`

## Adding an LSP Server

1. Create `lsp/<server_name>.lua` returning a config table (see existing files for examples)
2. Add the server name string to `language_servers` in `lua/base/lsp.lua`
3. `vim.lsp.enable()` picks it up automatically; the config file is loaded by Neovim's built-in
   LSP resolution from the `lsp/` directory

## Environment Flags (`helpers`)

These are set once at startup in `lua/helpers/init.lua` and available globally as `helpers.*`:

| Flag               | Condition                          | Effect                                            |
| ------------------ | ---------------------------------- | ------------------------------------------------- |
| `helpers.is_work`  | macOS (Darwin)                     | Disables MiniStarter, typst plugin, lualine icons |
| `helpers.is_nixos` | `/etc/os-release` contains `nixos` | Skips Mason; enables `nixd` LSP                   |

## Lock File Rationale

Two lock files exist because the config is used in two ways:

| File                      | Used by                                                      |
| ------------------------- | ------------------------------------------------------------ |
| `nvim-pack-lock.json`     | Plain Neovim — `vim.pack` reads this to pin plugin revisions |
| `nix-nvim-pack-lock.json` | Nix flake — `nix/neovim.nix` fetches plugins at build time   |

`sync-pack-revs.sh` copies the `rev` field for each plugin from the first file into the second,
keeping both in sync. CI runs this automatically after any lock update.

## `after/ftplugin/` Overrides

Only filetypes that differ from the global 2-space indent defaults need entries here:

| File           | Override                                 |
| -------------- | ---------------------------------------- |
| `python.vim`   | 4-space indent, `textwidth=79`           |
| `kdl.vim`      | 4-space indent                           |
| `markdown.lua` | `textwidth=80`, word-wrap, formatoptions |
