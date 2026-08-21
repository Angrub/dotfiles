# Angrub Dotfiles

*[Español](README.md) · **English***

Personal configurations, managed with [GNU Stow](https://www.gnu.org/software/stow/). Built for my two favorite GNU/Linux distros, **Arch Linux** and **Debian**.

## Contents

| Package | Description |
|---|---|
| `nvim` | Neovim 0.12+ with native LSP, blink.cmp, conform and fzf-lua |

## Installation

```bash
git clone  git@github.com:Angrub/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow nvim
```

Dry run, without applying any changes:

```bash
stow -n -v nvim
```

To revert:

```bash
stow -D nvim
```

## System dependencies

| Package | Dependencies |
|---|---|
| `nvim` | `stow` `fzf` `ripgrep` `fd` `nodejs` `npm` |

### Installation

```bash
# Arch
sudo pacman -S stow fzf ripgrep fd nodejs npm

# Debian
sudo apt install stow fzf ripgrep fd-find nodejs npm

# Rust (optional): the only LSP outside Mason, install only if you work with Rust
rustup component add rust-analyzer
```

## Neovim

The first time you open Neovim, lazy.nvim installs the plugins automatically. After that:

```vim
:Lazy restore
:MasonToolsInstall
```

Verification:

```vim
:checkhealth lsp
:checkhealth mason
:ConformInfo
```

### Structure

```
.
├── .gitignore
├── docs
│   ├── keymaps.en.md
│   └── keymaps.md
├── LICENSE
├── nvim
│   └── .config
│       └── nvim
│           ├── .stylua.toml
│           ├── init.lua
│           ├── lazy-lock.json
│           ├── lsp
│           │   ├── lua_ls.lua
│           │   └── ts_ls.lua
│           └── lua
│               ├── config
│               │   ├── lazy.lua
│               │   ├── lsp.lua
│               │   └── settings.lua
│               └── plugins
│                   ├── autopairs.lua
│                   ├── autotag.lua
│                   ├── blink.lua
│                   ├── colorschema.lua
│                   ├── format.lua
│                   ├── fzf.lua
│                   ├── lsp.lua
│                   └── tree-sitter.lua
├── README.en.md
└── README.md
```

### About the `lsp/` directory

It holds overrides only. Servers without a file of their own use the `nvim-lspconfig` defaults, which are correct. A file is added only when there is a concrete reason to change something.

### Per-machine configuration

If a machine needs adjustments that should not be versioned, create `lua/config/local.lua`. The `init.lua` loads it with `pcall` if it exists, and it is excluded in `.gitignore`.

### Summary

- **Plugin manager**: lazy.nvim, with `lazy-lock.json` versioned for reproducibility.
- **LSP**: Neovim's native API (`vim.lsp.config` / `vim.lsp.enable`). `nvim-lspconfig` is used only as a source of per-server configurations, not as a framework.
- **Tool installation**: Mason. `mason-tool-installer` manages a single list covering both servers and formatters.
- **Completion**: blink.cmp, pinned to `version = "1.*"` so it uses prebuilt binaries and requires no Rust toolchain.
- **Formatting**: conform.nvim. `stylua` for Lua, `biome` for JS/TS/JSON/CSS, and the corresponding LSP as a fallback for everything else.
- **Search**: fzf-lua, which also replaces the native selection menus (`vim.ui.select`).
- **Highlighting**: nvim-treesitter, `main` branch. The repository was archived in April 2026.

For the keybindings, click [here.](keymaps.en.md)
