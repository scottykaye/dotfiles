require("rose-pine").setup({
  dark_variant = "moon",
  groups = {
    border = "gold",
    panel = "none",
    comment = "muted",
    link = "iris",
    punctuation = "subtle",
    error = "love",
    hint = "iris",
    info = "foam",
    warn = "gold",

    git_add = "foam",
    git_change = "rose",
    git_delete = "love",
    git_dirty = "rose",
    git_ignore = "muted",
    git_merge = "iris",
    git_rename = "pine",
    git_stage = "iris",
    git_text = "rose",
    git_untracked = "subtle",
  },

  styles = {
    bold = true,
    italic = false,
    transparency = true,
  },

  --	highlight_groups = {
  --		Visual = { fg = "base", bg = "iris" },
  --		Cursor = { fg = "base", bg = "pine" },
  --		CursorColumn = { fg = "base", bg = "gold" },
  --		ColorColumn = { fg = "base", bg = "gold" },
  --		CursorLine = { bg = "muted", blend = 20 },
  --		LineNr = { fg = "iris", bg = "none" },
  --		CursorLineNr = { fg = "base", bg = "love" },
  --		IncSearch = { fg = "base", bg = "love" },
  --		Normal = { bg = "none" },
  --		NormalFloat = { bg = "none" },
  --		NormalNC = { bg = "none" },
  --		FloatBorder = { fg = "gold", bg = "none" },
  --		StatusLine = { fg = "love", bg = "muted", blend = 20 },
  --		StatusLineNC = { fg = "rose", bg = "muted", blend = 20 },
  --		TelescopeBorder = { fg = "gold", bg = "none" },
  --		TelescopeNormal = { fg = "text", bg = "none" },
  --		TelescopePromptNormal = { bg = "none" },
  --		TelescopeResultsNormal = { fg = "text", bg = "none" },
  --		TelescopeSelection = { fg = "love", bg = "muted", blend = 20 },
  --		TelescopeSelectionCaret = { fg = "rose", bg = "muted", blend = 20 },
  --		TelescopePromptBorder = { fg = "gold", bg = "none" },
  --
  --		TelescopeTitle = { fg = "text", bg = "none" },
  --		TelescopePromptTitle = { fg = "text", bg = "none" },
  --		TelescopePreviewTitle = { fg = "text", bg = "none" },
  --
  --		WinSeparator = { fg = "gold", bg = "none" },
  --		VertSplit = { fg = "gold", bg = "none" },
  --	},


  highlight_groups = {
    TelescopeBorder = { fg = "highlight_high", bg = "none" },
    TelescopeNormal = { bg = "none" },
    TelescopePromptNormal = { bg = "none" },
    TelescopeResultsNormal = { fg = "subtle", bg = "none" },
    TelescopeSelection = { fg = "text", bg = "base" },
    TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
    -- Added
    CursorLineNr = { fg = "base", bg = "iris" },


  },
  --	highlight_groups = {
  --		TelescopeBorder = { fg = "overlay", bg = "overlay" },
  --		TelescopeNormal = { fg = "subtle", bg = "overlay" },
  --		TelescopeSelection = { fg = "text", bg = "highlight_med" },
  --		TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
  --		TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
  --
  --		TelescopeTitle = { fg = "base", bg = "love" },
  --		TelescopePromptTitle = { fg = "base", bg = "pine" },
  --		TelescopePreviewTitle = { fg = "base", bg = "iris" },
  --
  --		TelescopePromptNormal = { fg = "text", bg = "surface" },
  --		TelescopePromptBorder = { fg = "surface", bg = "surface" },
  --	},
})

vim.cmd([[colorscheme rose-pine]])

local highlights = require("rose-pine.plugins.bufferline")
require("bufferline").setup({
  highlights = highlights,
  options = {
    close_command = "bp|sp|bn|bd! %d",
    right_mouse_command = "bp|sp|bn|bd! %d",
    left_mouse_command = "buffer %d",
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "",
    show_close_icon = false,
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 18,
    show_tab_indicators = true,
    indicator = {
      style = "underline",
    },
    enforce_regular_tabs = false,
    view = "multiwindow",
    show_buffer_close_icons = true,
    separator_style = "thin",
    -- separator_style = "slant",
    always_show_bufferline = true,
    diagnostics = false,
    themable = true,
  },
})

-- Go to the next tab
vim.keymap.set("n", "<leader>tn", ":BufferLineCycleNext<CR>", { desc = "Go to next tab" })
-- Go to the previous tab
vim.keymap.set("n", "<leader>tp", ":BufferLineCyclePrev<CR>", { desc = "Go to previous tab" })
-- Close the current tab
vim.keymap.set("n", "<leader>tct", ":BufferLinePickClose<CR>", { desc = "Pick close tab" })
vim.keymap.set("n", "<leader>tco", ":BufferLineCloseOthers<CR>", { desc = "Close all other tabs" })
-- Open a new tab
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open a new tab" })
-- sort by directory
vim.keymap.set("n", "<leader>ts", ":BufferLineSortByDirectory<CR>", { desc = "Open a new tab" })
-- close specific tabs
vim.keymap.set("n", "<leader>t1", ":BufferLineGoToBuffer 1<CR>", { desc = "Go To Bufferline 1" })
vim.keymap.set("n", "<leader>t2", ":BufferLineGoToBuffer 2<CR>", { desc = "Go To Bufferline 2" })
vim.keymap.set("n", "<leader>t3", ":BufferLineGoToBuffer 3<CR>", { desc = "Go To Bufferline 3" })
vim.keymap.set("n", "<leader>t4", ":BufferLineGoToBuffer 4<CR>", { desc = "Go To Bufferline 4" })
vim.keymap.set("n", "<leader>t5", ":BufferLineGoToBuffer 5<CR>", { desc = "Go To Bufferline 5" })
vim.keymap.set("n", "<leader>t6", ":BufferLineGoToBuffer 6<CR>", { desc = "Go To Bufferline 6" })
vim.keymap.set("n", "<leader>t7", ":BufferLineGoToBuffer 7<CR>", { desc = "Go To Bufferline 7" })
vim.keymap.set("n", "<leader>t8", ":BufferLineGoToBuffer 8<CR>", { desc = "Go To Bufferline 8" })
vim.keymap.set("n", "<leader>t9", ":BufferLineGoToBuffer 9<CR>", { desc = "Go To Bufferline 9" })
vim.keymap.set("n", "<leader>t10", ":BufferLineGoToBuffer 10<CR>", { desc = "Go To Bufferline 10" })
