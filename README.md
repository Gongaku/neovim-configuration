# Neovim Configuration

This repository contains my dotfiles for Neovim. There are probably better configurations,
be they more efficient, complex, or better-looking, but this is mine to play with.

## Prerequisites

- **Neovim 0.12 or later** — The config uses the native `vim.pack` plugin manager from this
  release line.
- **Git** — For cloning and for `vim.pack` to fetch plugin repositories.
- **Nix (optional)** — Only needed if you use the flake (`nix run`, Home Manager module, or
  wrapped `nvim`). Flakes must be enabled (`experimental-features = nix-command flakes`).

## Installation (plain Neovim)

Clone the repository into your Neovim config directory (replace the URL with your fork if
needed):

```bash
git clone https://github.com/Gongaku/neovim-configuration.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

Start Neovim once so `vim.pack` can download plugins. Revisions are recorded in
`nvim-pack-lock.json`.

### Lock files

| File                      | Role                                                    |
| ------------------------- | ------------------------------------------------------- |
| `nvim-pack-lock.json`     | Canonical plugin revisions from Neovim’s pack resolver. |
| `nix-nvim-pack-lock.json` | Same plugins pinned for the Nix-wrapped Neovim package. |

`sync-pack-revs.sh` copies revisions from `nvim-pack-lock.json` into
`nix-nvim-pack-lock.json` so CLI Neovim and the flake-built Neovim stay aligned. CI runs this
after lock updates.

## Nix flake

The flake exposes two outputs:

- **`packages.default`** — A wrapped `nvim` binary with this config baked in.

  ```bash
  nix run github:Gongaku/neovim-configuration
  ```

- **`homeManagerModules.default`** — A Home Manager module that installs Neovim (nightly via
  this flake’s overlay) and links this config under `~/.config/nvim/`.

  Add the repo as a flake input, then add the module to your Home Manager configuration:

  ```nix
  {
    inputs = {
      # ...
      nvim-config.url = "github:Gongaku/neovim-configuration";
    };
  }
  ```

  ```nix
  # In the `modules` list passed to home-manager.lib.homeManagerConfiguration (or equivalent):
  inputs.nvim-config.homeManagerModules.default
  ```

  If you import the module from a non-flake `home.nix`, expose the flake as an input your
  evaluator understands, or use `builtins.getFlake` / `fetchTarball` and pass the module path
  your setup expects. The module source also documents usage in `nix/home-manager.nix`.

## Formatting

From the repo root, `nix fmt` runs **treefmt** (Nix, shell, YAML, etc.) as defined in
`flake.nix`.
