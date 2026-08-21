# Keymap reference — Neovim

*[Español](keymaps.md) · **English***

Personal configuration: Neovim 0.12, lazy.nvim, native LSP (`vim.lsp.config`), blink.cmp, conform.nvim, fzf-lua.

- **Leader**: `<Space>`
- **LocalLeader**: `\`

> Keymaps marked as **built-in** ship with Neovim 0.11+ and are not defined in this configuration. They are documented here precisely because that makes them easy to forget: they appear in no file of my own.

---

## LSP — code navigation

| Keymap | Action | Source |
|---|---|---|
| `gd` | Go to definition (fzf-lua picker when there are several) | config |
| `gD` | Go to declaration. Only differs from `gd` in C/C++, where it leads to the prototype in the `.h` rather than the implementation | config |
| `grr` | List references to the symbol (picker) | config, overrides built-in |
| `gO` | Symbols in the current document (functions, types, variables) | config, overrides built-in |
| `gri` | Go to implementation (handy with interfaces in Go/TS) | built-in |
| `grt` | Go to type definition | built-in |
| `K` | Floating documentation for the symbol under the cursor | built-in |
| `<C-]>` | Go to definition via `tagfunc` (alternative to `gd`) | built-in |

## LSP — modifying code

| Keymap | Action | Source |
|---|---|---|
| `grn` | Rename symbol across the project | built-in |
| `gra` | Code actions (auto-import, quick fix, refactors). Works in normal and visual mode | built-in |
| `<C-s>` | Signature help in insert mode (parameters of the function being typed) | built-in |

`gra` goes through the fzf-lua selector thanks to `register_ui_select()`.

## Diagnostics

| Keymap | Action | Source |
|---|---|---|
| `]d` | Next diagnostic | built-in |
| `[d` | Previous diagnostic | built-in |
| `<C-w>d` | Show the diagnostic for the current line in a floating window | built-in |
| `<leader>fd` | List every diagnostic in the document (picker) | config |

Virtual text is shown only on the cursor line (`virtual_text = { current_line = true }`), to keep the screen readable.

---

## fzf-lua — search

| Keymap | Action |
|---|---|
| `<leader>ff` | Find a file by name |
| `<leader>fg` | Search text across the project (live grep) |
| `<leader>fw` | Search the word under the cursor |
| `<leader>fb` | Switch between open buffers |
| `<leader>fo` | Recently opened files |
| `<leader>fr` | Reopen the last search with its results intact |
| `<leader>fh` | Search the Neovim documentation (helptags) |
| `<leader>fk` | List every active keymap |
| `<leader>fd` | Diagnostics in the document |

The two that do 90% of the work: `<leader>ff` and `<leader>fg`.

### Inside the picker

| Key | Action |
|---|---|
| `<C-j>` / `<C-k>` | Move down / up the list |
| `<Enter>` | Open |
| `<C-v>` | Open in a vertical split |
| `<C-s>` | Open in a horizontal split |
| `<C-t>` | Open in a new tab |
| `<C-d>` / `<C-u>` | Page forward / backward |
| `<A-q>` | Send every result to the quickfix list |
| `<C-g>` | In live grep: toggles between live search and fuzzy filtering over the results already fetched |
| `<F1>` | Help with the keys for the current picker |
| `<Esc>` | Close |

If one of them doesn't respond, `<F1>` inside the picker shows the real list for the installed version.

In `live_grep` you can filter by file type using `rg` syntax (`rg_glob` is enabled):

```
useQuery -- *.ts
```

---

## blink.cmp — completion

The `default` preset. It only applies while the menu is visible; otherwise the keys keep their normal behavior.

| Keymap | Action |
|---|---|
| `<C-Space>` | Show the menu / toggle documentation |
| `<C-n>` / `<C-p>` | Next / previous suggestion |
| `<C-y>` | Accept the selected suggestion |
| `<C-e>` | Close the menu |
| `<C-b>` / `<C-f>` | Scroll the documentation window |
| `<Tab>` / `<S-Tab>` | Jump forward / backward between snippet fields |
| `<C-k>` | Toggle signature help |

Active sources, in priority order: LSP, file paths, snippets, buffer words. Plus lazydev in the configuration's own Lua files.

---

## Formatting

| Keymap | Action |
|---|---|
| `<leader>cf` | Format the file (or the selection, in visual mode) |

A single keymap for everything. conform picks the formatter based on the filetype:

| Filetype | Formatter |
|---|---|
| Lua | `stylua` (configured in `~/.config/nvim/.stylua.toml`) |
| JS, TS, JSX, TSX, JSON, JSONC, CSS | `biome` |
| Go, Python, Rust, C, C++ | The corresponding LSP (`lsp_format = "fallback"`) |

Format-on-save is disabled on purpose, to avoid large diffs in other people's projects.

---

## Useful commands

### Troubleshooting the configuration

| Command | What it's for |
|---|---|
| `:checkhealth` | General check |
| `:checkhealth lsp` | Which servers are attached to the buffer and why (replaces the old `:LspInfo`) |
| `:checkhealth mason` | Missing external tools (`node`, `npm`, `cargo`, ...) |
| `:checkhealth lazy` | Problems in the plugin specs |
| `:ConformInfo` | Which formatter applies to the current buffer, and whether the binary exists |
| `:lsp` | Interactive management of LSP clients (Neovim 0.12+) |
| `:MasonLog` | Logs for failed Mason installations |

### Plugins and tools

| Command | What it's for |
|---|---|
| `:Lazy` | Plugin manager interface |
| `:Lazy sync` | Install, update and clean; updates `lazy-lock.json` |
| `:Lazy restore` | Pin plugins to the commits in `lazy-lock.json` (use it when cloning on another machine) |
| `:Mason` | Interface for installing servers and tools |
| `:MasonToolsInstall` | Install everything listed under `ensure_installed` |
| `:MasonToolsUpdate` | Update the installed tools |
| `:restart` | Restart Neovim without quitting it (Neovim 0.12+) |

### Treesitter

No keymaps. Highlighting is enabled by an autocommand on every `FileType`. To add parsers, edit the list in `lua/plugins/tree-sitter.lua` and run `:TSUpdate`.
