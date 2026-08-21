# Angrub Dotfiles

***Español** · [English](README.en.md)*

Configuraciones personales, gestionadas con [GNU Stow](https://www.gnu.org/software/stow/). Pensadas para mis dos distros GNU/Linux favoritas **Arch Linux** y **Debian**.

## Contenido

| Paquete | Descripción |
|---|---|
| `nvim` | Neovim 0.12+ con LSP nativo, blink.cmp, conform y fzf-lua |

## Instalación

```bash
git clone git@github.com:Angrub/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow nvim
```

Para simular sin aplicar cambios:

```bash
stow -n -v nvim
```

Para revertir:

```bash
stow -D nvim
```

## Dependencias del sistema

| Paquete | Dependencias |
|---|---|
| `nvim` | `stow` `fzf` `ripgrep` `fd` `nodejs` `npm` | 

### Instalación

```bash
# Arch
sudo pacman -S stow fzf ripgrep fd nodejs npm

# Debian
sudo apt install stow fzf ripgrep fd-find nodejs npm

# Rust(opcional): único LSP fuera de Mason, sólo instalar si trabaja con rust
rustup component add rust-analyzer
```

## Neovim

Al abrir Neovim por primera vez, lazy.nvim instala los plugins automáticamente. Después:

```vim
:Lazy restore
:MasonToolsInstall
```

Verificación:

```vim
:checkhealth lsp
:checkhealth mason
:ConformInfo 
```

### Estructura

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

### Sobre el directorio `lsp/`

Contiene únicamente sobrescrituras. Los servidores sin archivo propio usan los valores por defecto de `nvim-lspconfig`, que son correctos. Se agrega un archivo solo cuando hay una razón concreta para cambiar algo.

### Configuración local por máquina

Si una máquina necesita ajustes que no deben versionarse, se crea `lua/config/local.lua`. El `init.lua` lo carga con `pcall` si existe, y está excluido en `.gitignore`.

### Resumen

- **Gestor de plugins**: lazy.nvim, con `lazy-lock.json` versionado para reproducibilidad. 
- **LSP**: API nativa de Neovim (`vim.lsp.config` / `vim.lsp.enable`). `nvim-lspconfig` se usa solo como fuente de configuraciones por servidor, no como framework.
- **Instalación de herramientas**: Mason. `mason-tool-installer` gestiona una sola lista con servidores y formateadores.
- **Completado**: blink.cmp, fijado a `version = "1.*"` para usar binarios precompilados y no requerir toolchain de Rust.
- **Formateo**: conform.nvim. `stylua` para Lua, `biome` para JS/TS/JSON/CSS, y el LSP correspondiente como respaldo para el resto.
- **Búsqueda**: fzf-lua, que también reemplaza los menús de selección nativos (`vim.ui.select`).
- **Resaltado**: nvim-treesitter, rama `main`. El repositorio fue archivado en abril de 2026.

Para ver los atajos de teclado haga clic [aquí.](docs/keymaps.md) 
