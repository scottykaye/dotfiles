# Neovim Keybindings Cheat Sheet

Leader = `<Space>`. This documents both **global `<leader>` keybindings** (which also
show up in the which-key popup) and **picker-internal keys** (which do *not* — they only
work inside an open picker/explorer and are documented here + via the built-in `?`).

> **Live help inside any Snacks picker/explorer:** press `?` (normal mode) or `?` in the
> input — Snacks shows every active mapping for that picker. Telescope pickers use `?`
> (normal) or `<C-/>` (insert) for the same thing.

---

## Snacks File Explorer (`<leader>fb`)

The file browser is **Snacks explorer** (`Snacks.picker.explorer()`), bound to
`<leader>fb`. These keys work *inside* the open explorer:

### Navigation / jumping

| Key            | Action                                            |
| -------------- | ------------------------------------------------- |
| `j` / `k`      | Move selection down / up                          |
| `gg` / `G`     | Jump to **top** / **bottom** of the list          |
| `<C-d>` / `<C-u>` | Scroll the list down / up (half page)          |
| `<CR>` or `l`  | Open file **or** expand/toggle directory          |
| `h`            | Collapse / close the current directory            |
| `<BS>`         | Go **up** one directory (out of current dir)       |
| `.`            | Focus current directory (set it as cwd)           |
| `Z`            | Close **all** directories                         |
| `]g` / `[g`    | Jump to next / previous git change                |
| `]d` / `[d`    | Jump to next / previous diagnostic                |
| `]e` / `[e`    | Jump to next / previous error                     |
| `]w` / `[w`    | Jump to next / previous warning                   |

### Toggles & view

| Key      | Action                                       |
| -------- | -------------------------------------------- |
| `H`      | Toggle hidden files                          |
| `I`      | Toggle ignored files (from .gitignore)       |
| `P`      | Toggle preview pane                          |
| `?`      | Show the full keymap cheat sheet (live)      |

### File operations

| Key       | Action                                                |
| --------- | ----------------------------------------------------- |
| `a`       | **Add** a new file or directory (end with `/` for dir)|
| `d`       | **Delete** (uses system trash if available)           |
| `o`       | **Open** with the system application                  |
| `u`       | **Update/refresh** the tree                           |
| `<Tab>`   | Toggle-select a file (multi-select)                   |
| `y`       | **Yank** selected file path(s) to a register          |
| `p`       | **Paste** (copy) yanked files into current dir        |
| `v` / `V` | Visual-select multiple files, then operate on them    |

### Quick actions

| Key         | Action                                  |
| ----------- | --------------------------------------- |
| `<leader>/` | Grep within the current directory       |
| `<C-t>`     | Open a terminal in the current directory|
| `<C-c>`     | Change tab directory to current dir     |

---

## Snacks Pickers (find files, grep, buffers, etc.)

All `Snacks.picker.*` pickers share the same navigation. Useful jumps:

| Key                | Action                                  |
| ------------------ | --------------------------------------- |
| `<C-j>` / `<C-k>`  | Move selection down / up (while typing) |
| `gg` / `G`         | Jump to top / bottom (normal mode)      |
| `<C-d>` / `<C-u>`  | Scroll list down / up                   |
| `<C-f>` / `<C-b>`  | Scroll **preview** down / up            |
| `<a-p>`            | Toggle preview                          |
| `?`                | Toggle the live help / keymap list      |

### Global picker keybindings (show in which-key)

| Key          | Picker                          |
| ------------ | ------------------------------- |
| `<leader>sm` | Smart find files                |
| `<leader>pf` | Find files                      |
| `<leader>fg` | Find git files                  |
| `<leader>fr` | Recent files                    |
| `<leader>fc` | Find config file                |
| `<leader>fp` | Projects                        |
| `<leader>fb` | File explorer                   |
| `<leader>b`  | Buffers                         |
| `<leader>ps` / `<leader>sg` | Grep             |
| `<leader>sw` | Grep word / visual selection    |
| `<leader>sb` | Buffer lines                    |
| `<leader>sB` | Grep open buffers               |
| `<leader>sd` | Diagnostics                     |
| `<leader>sk` | Keymaps                         |
| `<leader>sh` | Help pages                      |
| `<leader>sj` | Jumps                           |
| `<leader>:`  | Command history                 |
| `<leader>n`  | Notification history            |

### Git pickers

| Key          | Action            |
| ------------ | ----------------- |
| `<leader>gb` | Git branches      |
| `<leader>gl` | Git log           |
| `<leader>gL` | Git log line      |
| `<leader>gs` | Git status        |
| `<leader>gS` | Git stash         |
| `<leader>gd` | Git diff (hunks)  |
| `<leader>gf` | Git log file      |

---

## Core editing leader maps (from `remap.lua`)

| Key                 | Action                                  |
| ------------------- | --------------------------------------- |
| `<leader>w` / `<leader>W` | Write file                        |
| `<leader>c`         | Clear search highlight                  |
| `<leader>pv`        | Open netrw file explorer                |
| `<leader>y` / `<leader>Y` | Yank to system clipboard          |
| `<leader>d`         | Delete to black hole register           |
| `<leader>p` (visual)| Paste without yanking the selection     |
| `<leader>\|`        | Vertical split                          |
| `<leader>-`         | Horizontal split                        |
| `<leader>h`         | Search word under cursor                |
| `<leader>s` / `<leader>S` | Substitute word under cursor      |
| `<leader>k` / `<leader>j` | Next / prev location-list item    |
| `<leader>x`         | `chmod +x` current file                 |
| `<leader><leader>`  | Source current file                     |

---

## LSP leader maps (active when an LSP attaches)

| Key                  | Action                              |
| -------------------- | ----------------------------------- |
| `gd` / `gD`          | Go to definition / declaration      |
| `gr`                 | References                          |
| `gi`                 | Implementation                     |
| `K`                  | Hover docs                          |
| `<C-h>`              | Signature help                      |
| `<leader>ca` / `<leader>vca` | Code actions (incl. "Add missing imports") |
| `<leader>vrn` / `<space>rn`  | Rename                      |
| `<leader>D`          | Type definition                     |
| `<space>e` / `<leader>vd` | Show diagnostics (float)       |
| `[d` / `]d`          | Prev / next diagnostic              |
| `<space>q`           | Diagnostics to location list        |

> **Auto-import on save:** for TS/JS files, saving runs the ts_ls
> `source.addMissingImports.ts` action automatically, adding any missing imports
> (using `project-relative` style — relative within a package, `:alias` across packages).

---

## Notes

- **Picker-internal keys can't live in the which-key leader chart** — they aren't leader
  keys. Use `?` inside any picker for the always-current list. This file is the
  human-readable mirror.
- If a `<leader>` key shows blank in which-key, its `vim.keymap.set` is missing a
  `desc =`. Add one to document it.
