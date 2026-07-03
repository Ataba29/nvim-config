# My Neovim Config

A `lazy.nvim`-based setup with LSP (via Mason), Telescope, Treesitter, auto-formatting,
linting, and git tooling. Leader key is **Space**.

## 1. Requirements

Install these before first launch:

- **Neovim ≥ 0.10** (needed for `vim.uv` and modern LSP features)
- **git** (lazy.nvim bootstraps itself via git clone)
- **A Nerd Font** (for the icons in lualine, nvim-tree, which-key, etc.) — e.g. [FiraCode Nerd Font](https://www.nerdfonts.com/), set it as your terminal font
- **ripgrep** (`rg`) — required for Telescope live grep
- **lazygit** — required for the `<leader>tg` terminal toggle
- **A C compiler** (gcc/clang) — Treesitter compiles parsers on install

### Formatter/linter binaries (used by conform.nvim / nvim-lint)

These are **not** installed automatically — install what you need for your languages:

| Tool             | Used for                                     | Install via                                            |
| ---------------- | -------------------------------------------- | ------------------------------------------------------ |
| `stylua`         | Lua formatting                               | `cargo install stylua` or Mason (`:Mason`)             |
| `black`, `isort` | Python formatting                            | `pip install black isort`                              |
| `ruff`           | Python linting                               | `pip install ruff`                                     |
| `prettier`       | JS/TS/HTML/CSS/JSON/YAML/Markdown formatting | `npm install -g prettier`                              |
| `eslint_d`       | JS/TS linting                                | `npm install -g eslint_d`                              |
| `clang-format`   | C/C++ formatting                             | usually ships with LLVM, or `apt install clang-format` |
| `cpplint`        | C/C++ linting                                | `pip install cpplint`                                  |
| `cmake-format`   | CMake formatting                             | `pip install cmake-format`                             |

LSP servers themselves (lua_ls, pyright, ts_ls, html, cssls, jsonls, yamlls, clangd, cmake)
install automatically on first launch via Mason.

## 2. Installation

1. Back up any existing config: `mv ~/.config/nvim ~/.config/nvim.bak`
2. Copy `init.lua` into `~/.config/nvim/init.lua`
3. Launch `nvim` — lazy.nvim will bootstrap itself and install all plugins automatically
4. Run `:Mason` to confirm LSP servers installed correctly; run `:MasonInstall <name>` for any that failed
5. Run `:checkhealth` to catch any missing dependencies

## 3. What's included

| Category       | Plugin                            | Purpose                                               |
| -------------- | --------------------------------- | ----------------------------------------------------- |
| Plugin manager | lazy.nvim                         | Installs/loads everything below                       |
| Colorscheme    | monokai-pro.nvim                  | Theme                                                 |
| Statusline     | lualine.nvim                      | Bottom status bar                                     |
| File explorer  | nvim-tree.lua                     | Sidebar file tree                                     |
| Fuzzy finder   | telescope.nvim                    | Find files, grep, search everything                   |
| LSP installer  | mason.nvim + mason-lspconfig.nvim | Manages LSP servers                                   |
| LSP client     | nvim-lspconfig                    | Hooks servers into Neovim                             |
| Formatting     | conform.nvim                      | Format-on-save                                        |
| Linting        | nvim-lint                         | Extra diagnostics beyond LSP                          |
| Syntax         | nvim-treesitter                   | Better highlighting/indent                            |
| Completion     | nvim-cmp + LuaSnip                | Autocomplete + snippets                               |
| Git signs      | gitsigns.nvim                     | Gutter git markers                                    |
| Git diff       | diffview.nvim                     | Full diff views                                       |
| Autopairs      | nvim-autopairs                    | Auto-close brackets/quotes                            |
| Comments       | Comment.nvim                      | Toggle comments                                       |
| TODOs          | todo-comments.nvim                | Highlight/search TODO, FIXME, etc.                    |
| Keybind help   | which-key.nvim                    | Popup showing available keys                          |
| Terminal       | toggleterm.nvim                   | Floating/split terminals, incl. lazygit & python REPL |
| Motion         | flash.nvim                        | Jump to any visible location fast                     |
| Indent guides  | indent-blankline.nvim             | Vertical indent lines                                 |
| Dashboard      | alpha-nvim                        | Start screen                                          |

## 4. Keybindings

Leader = `Space`. In the tables below, `<leader>` means press Space then the given keys.

### General

| Keys        | Action                                             |
| ----------- | -------------------------------------------------- |
| `<Esc>`     | Clear search highlight                             |
| `<leader>f` | Format current buffer (conform, falls back to LSP) |

### LSP (active once a language server attaches to a buffer)

| Keys         | Action                             |
| ------------ | ---------------------------------- |
| `gd`         | Go to definition                   |
| `gD`         | Go to declaration                  |
| `gi`         | Go to implementation               |
| `gr`         | Go to references                   |
| `K`          | Hover documentation                |
| `<C-k>`      | Signature help (insert mode)       |
| `<leader>rn` | Rename symbol                      |
| `<leader>ca` | Code action                        |
| `[d` / `]d`  | Previous / next diagnostic         |
| `<leader>e`  | Show diagnostic in floating window |
| `<leader>q`  | Diagnostics to location list       |

### File explorer

| Keys         | Action           |
| ------------ | ---------------- |
| `<leader>pv` | Toggle file tree |
| `<leader>pf` | Focus file tree  |

### Telescope (search)

| Keys               | Action                             |
| ------------------ | ---------------------------------- |
| `<leader><leader>` | Find open buffers                  |
| `<leader>sf`       | Search files                       |
| `<leader>sg`       | Live grep (search text in project) |
| `<leader>sw`       | Search current word under cursor   |
| `<leader>sh`       | Search help tags                   |
| `<leader>sk`       | Search keymaps                     |
| `<leader>ss`       | Search Telescope's own pickers     |
| `<leader>sd`       | Search diagnostics                 |
| `<leader>sr`       | Resume last search                 |
| `<leader>s.`       | Recent files                       |
| `<leader>st`       | Search TODO comments               |

### Motion (flash.nvim)

| Keys                   | Action                                                    |
| ---------------------- | --------------------------------------------------------- |
| `s`                    | Flash jump (normal/visual/operator mode)                  |
| `S`                    | Flash treesitter jump (jump to a syntax node)             |
| `r` (operator-pending) | Remote flash (act on a target without moving there first) |
| `R`                    | Treesitter search                                         |

> ⚠️ `s`/`S` are remapped from Vim's default "substitute character" behavior.
> If you rely on `s`/`S` for substitution, let me know and I'll rebind flash to
> something like `<leader>j`/`<leader>k` instead.

### Windows & buffers

| Keys                     | Action                 |
| ------------------------ | ---------------------- |
| `<C-h/j/k/l>`            | Move between windows   |
| `<C-Up/Down/Left/Right>` | Resize window          |
| `<S-l>` / `<S-h>`        | Next / previous buffer |
| `<leader>bd`             | Delete (close) buffer  |

### Terminal

| Keys                             | Action                         |
| -------------------------------- | ------------------------------ |
| `<leader>ts`                     | Toggle terminal                |
| `<leader>th`                     | Horizontal terminal            |
| `<leader>tv`                     | Vertical terminal              |
| `<leader>tf`                     | Floating terminal              |
| `<leader>tg`                     | Toggle lazygit                 |
| `<leader>tp`                     | Toggle Python REPL             |
| `<C-n>` (in terminal mode)       | Toggle terminal from inside it |
| `<C-h/j/k/l>` (in terminal mode) | Move to another window         |

### Git diff (diffview.nvim)

| Keys         | Action                        |
| ------------ | ----------------------------- |
| `<leader>gd` | Open diff view                |
| `<leader>gh` | File history for current file |
| `<leader>gc` | Close diff view               |

### Editing

| Keys                           | Action                             |
| ------------------------------ | ---------------------------------- |
| `<`/`>` (visual mode)          | Indent, staying in visual mode     |
| `<A-j>` / `<A-k>`              | Move selected line(s) down/up      |
| `p` (visual mode)              | Paste without overwriting register |
| `J` / `K` (visual/select mode) | Move selection down/up             |

## 5. Notes

- Trailing whitespace is stripped on save for all filetypes **except** Markdown and diff
  files (where trailing spaces can be meaningful).
- Format-on-save is enabled by default (via conform.nvim) for the filetypes listed in the
  requirements table above — if you don't have the relevant formatter binary installed,
  it silently no-ops for that filetype rather than erroring.
- Run `:Lazy` any time to see plugin status, updates, or profiling info.
- Run `:Mason` any time to manage installed LSP servers.
