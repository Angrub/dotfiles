# Referencia de keymaps — Neovim

***Español** · [English](keymaps.en.md)*

Configuración personal: Neovim 0.12, lazy.nvim, LSP nativo (`vim.lsp.config`), blink.cmp, conform.nvim, fzf-lua.

- **Leader**: `<Space>`
- **LocalLeader**: `\`

> Los atajos marcados como **nativo** vienen incluidos en Neovim 0.11+ y no están definidos en la configuración. Se documentan aquí porque son fáciles de olvidar precisamente por eso: no aparecen en ningún archivo propio.

---

## LSP — navegación de código

| Atajo | Acción | Origen |
|---|---|---|
| `gd` | Ir a la definición (picker de fzf-lua si hay varias) | config |
| `gD` | Ir a la declaración. Solo difiere de `gd` en C/C++: lleva al prototipo en el `.h` en lugar de la implementación | config |
| `grr` | Listar referencias del símbolo (picker) | config, sobrescribe nativo |
| `gO` | Símbolos del documento actual (funciones, tipos, variables) | config, sobrescribe nativo |
| `gri` | Ir a la implementación (útil con interfaces en Go/TS) | nativo |
| `grt` | Ir a la definición del tipo | nativo |
| `K` | Documentación flotante del símbolo bajo el cursor | nativo |
| `<C-]>` | Ir a la definición vía `tagfunc` (alternativa a `gd`) | nativo |

## LSP — modificar código

| Atajo | Acción | Origen |
|---|---|---|
| `grn` | Renombrar símbolo en todo el proyecto | nativo |
| `gra` | Code actions (auto-import, quick fix, refactors). Funciona en normal y visual | nativo |
| `<C-s>` | Signature help en modo insert (parámetros de la función que estás escribiendo) | nativo |

`gra` pasa por el selector de fzf-lua gracias a `register_ui_select()`.

## Diagnósticos

| Atajo | Acción | Origen |
|---|---|---|
| `]d` | Siguiente diagnóstico | nativo |
| `[d` | Diagnóstico anterior | nativo |
| `<C-w>d` | Mostrar el diagnóstico de la línea en ventana flotante | nativo |
| `<leader>fd` | Listar todos los diagnósticos del documento (picker) | config |

El texto virtual solo se muestra en la línea del cursor (`virtual_text = { current_line = true }`), para no saturar la pantalla.

---

## fzf-lua — búsqueda

| Atajo | Acción |
|---|---|
| `<leader>ff` | Buscar archivo por nombre |
| `<leader>fg` | Buscar texto en todo el proyecto (live grep) |
| `<leader>fw` | Buscar la palabra bajo el cursor |
| `<leader>fb` | Cambiar entre buffers abiertos |
| `<leader>fo` | Archivos abiertos recientemente |
| `<leader>fr` | Reabrir la última búsqueda con sus resultados intactos |
| `<leader>fh` | Buscar en la documentación de Neovim (helptags) |
| `<leader>fk` | Listar todos los keymaps activos |
| `<leader>fd` | Diagnósticos del documento |

Los dos que hacen el 90% del trabajo: `<leader>ff` y `<leader>fg`.

### Dentro del picker

| Tecla | Acción |
|---|---|
| `<C-j>` / `<C-k>` | Bajar / subir en la lista |
| `<Enter>` | Abrir |
| `<C-v>` | Abrir en split vertical |
| `<C-s>` | Abrir en split horizontal |
| `<C-t>` | Abrir en pestaña nueva |
| `<C-d>` / `<C-u>` | Avanzar / retroceder una página |
| `<A-q>` | Enviar todos los resultados a la quickfix list |
| `<C-g>` | En live grep: alterna entre búsqueda en vivo y fuzzy sobre resultados ya obtenidos |
| `<F1>` | Ayuda con los atajos del picker actual |
| `<Esc>` | Cerrar |

Si alguno no responde, `<F1>` dentro del picker muestra la lista real de la versión instalada.

En `live_grep` se puede filtrar por tipo de archivo con la sintaxis de `rg` (`rg_glob` está activado):

```
useQuery -- *.ts
```

---

## blink.cmp — completado

Preset `default`. Solo aplica cuando el menú está visible; si no, las teclas conservan su comportamiento normal.

| Atajo | Acción |
|---|---|
| `<C-Space>` | Mostrar el menú / alternar la documentación |
| `<C-n>` / `<C-p>` | Siguiente / anterior sugerencia |
| `<C-y>` | Aceptar la sugerencia seleccionada |
| `<C-e>` | Cerrar el menú |
| `<C-b>` / `<C-f>` | Desplazar la ventana de documentación |
| `<Tab>` / `<S-Tab>` | Avanzar / retroceder entre los campos de un snippet |
| `<C-k>` | Alternar signature help |

Fuentes activas, en orden de prioridad: LSP, rutas de archivo, snippets, palabras del buffer. Más lazydev en archivos Lua de la configuración.

---

## Formateo

| Atajo | Acción |
|---|---|
| `<leader>cf` | Formatear el archivo (o la selección, en modo visual) |

Un solo atajo para todo. conform elige el formateador según el filetype:

| Filetype | Formateador |
|---|---|
| Lua | `stylua` (config en `~/.config/nvim/.stylua.toml`) |
| JS, TS, JSX, TSX, JSON, JSONC, CSS | `biome` |
| Go, Python, Rust, C, C++ | El LSP correspondiente (`lsp_format = "fallback"`) |

El formateo al guardar está desactivado a propósito, para evitar diffs grandes en proyectos ajenos.

---

## Comandos útiles

### Diagnóstico de la configuración

| Comando | Para qué |
|---|---|
| `:checkhealth` | Revisión general |
| `:checkhealth lsp` | Qué servidores están adjuntos al buffer y por qué (reemplaza al viejo `:LspInfo`) |
| `:checkhealth mason` | Herramientas externas que faltan (`node`, `npm`, `cargo`, ...) |
| `:checkhealth lazy` | Problemas en los specs de plugins |
| `:ConformInfo` | Qué formateador aplica al buffer actual y si el binario existe |
| `:lsp` | Gestión interactiva de clientes LSP (Neovim 0.12+) |
| `:MasonLog` | Logs de instalaciones fallidas de Mason |

### Plugins y herramientas

| Comando | Para qué |
|---|---|
| `:Lazy` | Interfaz del gestor de plugins |
| `:Lazy sync` | Instalar, actualizar y limpiar; actualiza `lazy-lock.json` |
| `:Lazy restore` | Fijar los plugins a los commits del `lazy-lock.json` (usar al clonar en otra máquina) |
| `:Mason` | Interfaz de instalación de servidores y herramientas |
| `:MasonToolsInstall` | Instalar todo lo listado en `ensure_installed` |
| `:MasonToolsUpdate` | Actualizar las herramientas instaladas |
| `:restart` | Reiniciar Neovim sin cerrarlo (Neovim 0.12+) |

### Treesitter

No tiene atajos. El resaltado se activa por autocomando en cada `FileType`. Para añadir parsers, editar la lista en `lua/plugins/tree-sitter.lua` y correr `:TSUpdate`.

