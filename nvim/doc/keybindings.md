# Neovim Keybindings Cheat Sheet

Leader key: `<Space>`

## Quick Navigation

| Key          | Description                 |
| ------------ | --------------------------- |
| `<leader>?`  | Show this cheat sheet       |
| `<leader>sk` | Search all keymaps (picker) |

**Tip:** When viewing this cheat sheet, use `{` and `}` to jump between sections, or `<C-d>` / `<C-u>` for half-page scrolling.

## File Operations

| Key                       | Description                |
| ------------------------- | -------------------------- |
| `<leader>w` / `<leader>W` | Write (save) file          |
| `<leader>pv`              | Open netrw (file explorer) |
| `<leader>fb`              | File explorer (Snacks)     |
| `<leader>pf`              | Find files (Snacks)        |
| `<leader>fg`              | Find git files (Snacks)    |
| `<leader>fc`              | Find config files (Snacks) |
| `<leader>fr`              | Recent files (Snacks)      |
| `<leader>fp`              | Projects (Snacks)          |
| `<leader>sm`              | Smart find files (Snacks)  |

## Buffers & Tabs

| Key               | Description            |
| ----------------- | ---------------------- |
| `<leader>b`       | List buffers (Snacks)  |
| `<leader>bd`      | Delete buffer (Snacks) |
| `<leader>tn`      | Next tab               |
| `<leader>tp`      | Previous tab           |
| `<leader>tct`     | Pick a tab to close    |
| `<leader>tco`     | Close all other tabs   |
| `<leader>to`      | Open a new tab         |
| `<leader>ts`      | Sort tabs by directory |
| `<leader>t1`-`t9` | Go to tab 1-9          |
| `<leader>t10`     | Go to tab 10           |

## Navigation

| Key         | Description                       |
| ----------- | --------------------------------- |
| `<C-d>`     | Half page down (centered)         |
| `<C-u>`     | Half page up (centered)           |
| `n`         | Next search result (centered)     |
| `N`         | Previous search result (centered) |
| `<C-k>`     | Next quickfix item                |
| `<C-j>`     | Previous quickfix item            |
| `<leader>k` | Next location list item           |
| `<leader>j` | Previous location list item       |

## Harpoon (Quick File Switching)

| Key         | Description               |
| ----------- | ------------------------- |
| `<leader>a` | Add file to Harpoon list  |
| `<C-e>`     | Toggle Harpoon quick menu |
| `<C-h>`     | Select Harpoon file 1     |
| `<C-n>`     | Select Harpoon file 0     |
| `<C-s>`     | Select Harpoon file 4     |
| `<C-S-P>`   | Previous Harpoon file     |
| `<C-S-N>`   | Next Harpoon file         |

## Flash (Jump/Search)

| Key     | Mode    | Description                       |
| ------- | ------- | --------------------------------- |
| `s`     | n, x, o | Flash jump                        |
| `S`     | n, x, o | Flash treesitter select           |
| `r`     | o       | Flash remote (e.g., `yr<jump>iw`) |
| `R`     | o, x    | Flash treesitter search           |
| `<C-s>` | c       | Toggle Flash in search mode       |

## Editing - Line Movement

| Key                    | Mode | Description                       |
| ---------------------- | ---- | --------------------------------- |
| `<M-Down>` / `<A-j>`   | n, i | Move line down                    |
| `<M-Up>` / `<A-k>`     | n, i | Move line up                      |
| `<S-M-Down>` / `<A-J>` | n, i | Duplicate line down               |
| `<S-M-Up>` / `<A-K>`   | n, i | Duplicate line up                 |
| `J`                    | v    | Move selected lines down          |
| `K`                    | v    | Move selected lines up            |
| `J`                    | n    | Join lines (keep cursor position) |

## Editing - Yank/Paste/Delete

| Key          | Mode | Description                    |
| ------------ | ---- | ------------------------------ |
| `<leader>y`  | n, v | Yank to system clipboard       |
| `<leader>Y`  | n    | Yank line to system clipboard  |
| `<leader>p`  | x    | Paste without losing clipboard |
| `<leader>pc` | v    | Paste and keep original        |
| `p`          | v    | Paste and keep what was pasted |
| `<leader>d`  | n, v | Delete to black hole register  |

## Search & Replace

| Key                       | Description                     |
| ------------------------- | ------------------------------- |
| `<leader>h`               | Search for word under cursor    |
| `<leader>s` / `<leader>S` | Substitute word under cursor    |
| `<leader>c`               | Clear search highlight          |
| `<leader>ps`              | Grep (Snacks)                   |
| `<leader>sg`              | Grep (Snacks)                   |
| `<leader>sw`              | Grep word under cursor (Snacks) |
| `<leader>sb`              | Search buffer lines (Snacks)    |
| `<leader>sB`              | Grep open buffers (Snacks)      |

## LSP

| Key           | Description                    |
| ------------- | ------------------------------ |
| `gd`          | Go to definition               |
| `gD`          | Go to declaration              |
| `gr`          | Find references                |
| `gI`          | Go to implementation           |
| `gy`          | Go to type definition          |
| `K`           | Show hover documentation       |
| `<C-h>`       | Signature help                 |
| `[d`          | Previous diagnostic            |
| `]d`          | Next diagnostic                |
| `<leader>e`   | Show errors (picker)           |
| `<leader>fe`  | Go to first error              |
| `<leader>vd`  | Open diagnostic float          |
| `<leader>vrn` | Rename symbol                  |
| `<leader>vca` | Code action                    |
| `<space>rn`   | Rename (alternate)             |
| `<leader>ss`  | LSP symbols (Snacks)           |
| `<leader>sS`  | LSP workspace symbols (Snacks) |
| `<leader>sd`  | Diagnostics (Snacks)           |
| `<leader>sD`  | Buffer diagnostics (Snacks)    |

## Git

| Key          | Description             |
| ------------ | ----------------------- |
| `<leader>gb` | Git branches (Snacks)   |
| `<leader>gl` | Git log (Snacks)        |
| `<leader>gL` | Git log line (Snacks)   |
| `<leader>gs` | Git status (Snacks)     |
| `<leader>gS` | Git stash (Snacks)      |
| `<leader>gd` | Git diff/hunks (Snacks) |
| `<leader>gf` | Git log file (Snacks)   |
| `<leader>gB` | Git browse (Snacks)     |
| `<leader>gg` | Lazygit (Snacks)        |

## Git Hunks (Gitsigns)

| Key          | Mode | Description               |
| ------------ | ---- | ------------------------- |
| `]c`         | n    | Next git hunk             |
| `[c`         | n    | Previous git hunk         |
| `<leader>hs` | n, v | Stage hunk                |
| `<leader>hr` | n, v | Reset hunk                |
| `<leader>hS` | n    | Stage buffer              |
| `<leader>hu` | n    | Undo stage hunk           |
| `<leader>hR` | n    | Reset buffer              |
| `<leader>hp` | n    | Preview hunk              |
| `<leader>hb` | n    | Blame line (full)         |
| `<leader>tb` | n    | Toggle current line blame |
| `<leader>hd` | n    | Diff this                 |
| `<leader>hD` | n    | Diff this (~)             |
| `<leader>td` | n    | Toggle deleted            |
| `ih`         | o, x | Select hunk (text object) |

## Error Navigation

| Key  | Description                         |
| ---- | ----------------------------------- |
| `]e` | Next error (across all buffers)     |
| `[e` | Previous error (across all buffers) |

## Merge Conflicts

| Key          | Description                                 |
| ------------ | ------------------------------------------- |
| `<leader>fc` | Find merge conflicts (picker)               |
| `<leader>mc` | Go to first merge conflict                  |
| `]n`         | Next merge conflict                         |
| `[n`         | Previous merge conflict                     |
| `<leader>ch` | Keep HEAD section (ours), delete incoming   |
| `<leader>ci` | Keep incoming section (theirs), delete HEAD |
| `<leader>cb` | Keep both sections (remove markers only)    |
| `<leader>cn` | Delete entire conflict (keep neither)       |
| `<leader>vh` | Visually select HEAD section                |
| `<leader>vi` | Visually select incoming section            |

## Snacks Features

| Key               | Description               |
| ----------------- | ------------------------- |
| `<leader>z`       | Toggle Zen mode           |
| `<leader>Z`       | Toggle Zoom               |
| `<leader>.`       | Toggle scratch buffer     |
| `<leader>S`       | Select scratch buffer     |
| `<leader>n`       | Notification history      |
| `<leader>un`      | Dismiss all notifications |
| `<C-/>` / `<C-_>` | Toggle terminal           |

## Search Utilities (Snacks)

| Key          | Description           |
| ------------ | --------------------- |
| `<leader>:`  | Command history       |
| `<leader>s"` | Registers             |
| `<leader>s/` | Search history        |
| `<leader>sa` | Autocmds              |
| `<leader>sc` | Command history       |
| `<leader>sC` | Commands              |
| `<leader>sh` | Help pages            |
| `<leader>sH` | Highlights            |
| `<leader>si` | Icons                 |
| `<leader>sj` | Jumps                 |
| `<leader>sk` | Keymaps (interactive) |
| `<leader>sl` | Location list         |
| `<leader>sm` | Marks                 |
| `<leader>sM` | Man pages             |
| `<leader>sp` | Plugin specs (Lazy)   |
| `<leader>sq` | Quickfix list         |
| `<leader>sR` | Resume last picker    |
| `<leader>su` | Undo history          |

## Toggles

| Key          | Description                  |
| ------------ | ---------------------------- |
| `<leader>us` | Toggle spelling              |
| `<leader>uw` | Toggle wrap                  |
| `<leader>uL` | Toggle relative numbers      |
| `<leader>ud` | Toggle diagnostics           |
| `<leader>ul` | Toggle line numbers          |
| `<leader>uc` | Toggle conceal level         |
| `<leader>uT` | Toggle treesitter            |
| `<leader>ub` | Toggle dark/light background |
| `<leader>uh` | Toggle inlay hints           |
| `<leader>ug` | Toggle indent guides         |
| `<leader>uD` | Toggle dim                   |
| `<leader>uC` | Colorschemes picker          |

## Formatting

| Key                   | Description                |
| --------------------- | -------------------------- |
| `<leader>F`           | Format current file        |
| `:Format`             | Format with closest config |
| `:FormatWithBiome`    | Format with Biome          |
| `:FormatWithPrettier` | Format with Prettier       |

## Custom Commands

| Command   | Description                         |
| --------- | ----------------------------------- |
| `:Cpath`  | Copy relative path to clipboard     |
| `:Capath` | Copy absolute path to clipboard     |
| `:Gpath`  | Copy git-relative path to clipboard |

## Utilities

| Key                | Description                       |
| ------------------ | --------------------------------- |
| `<leader>u`        | Toggle Undotree                   |
| `<leader>x`        | Make file executable              |
| `<leader>mr`       | Make it rain (cellular automaton) |
| `<leader><leader>` | Source current file               |
| `<leader>N`        | Neovim news                       |
| `<leader>cR`       | Rename file (Snacks)              |
| `<C-c>`            | Escape insert mode                |
| `Q`                | Disabled (noop)                   |

## Copilot (AI Suggestions)

| Key         | Mode | Description         |
| ----------- | ---- | ------------------- |
| `<C-f>`     | i    | Accept suggestion   |
| `<C-Right>` | i    | Accept word         |
| `<C-Down>`  | i    | Accept line         |
| `<M-]>`     | i    | Next suggestion     |
| `<M-[>`     | i    | Previous suggestion |
| `<C-]>`     | i    | Dismiss suggestion  |

## Profiling

| Key          | Description                |
| ------------ | -------------------------- |
| `<leader>pp` | Toggle profiler            |
| `<leader>ph` | Toggle profiler highlights |

## Word Navigation

| Key  | Description                           |
| ---- | ------------------------------------- |
| `]]` | Next reference (Snacks word jump)     |
| `[[` | Previous reference (Snacks word jump) |
| `{`  | Previous paragraph/section            |
| `}`  | Next paragraph/section                |

---

**Tips:**

- Use `/` to search in this buffer
- Use `{` and `}` to jump between sections in markdown/docs
- Use `<leader>sk` for an interactive keymap picker
