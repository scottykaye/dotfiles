require("rose-pine").setup({
  dark_variant = 'moon',
  groups = {
    border        = "gold",
    panel         = "none",
    comment       = 'muted',
    link          = 'iris',
    punctuation   = 'subtle',
    error         = 'love',
    hint          = 'iris',
    info          = 'foam',
    warn          = 'gold',

    git_add       = "foam",
    git_change    = "rose",
    git_delete    = "love",
    git_dirty     = "rose",
    git_ignore    = "muted",
    git_merge     = "iris",
    git_rename    = "pine",
    git_stage     = "iris",
    git_text      = "rose",
    git_untracked = "subtle",
  },

  styles = {
    bold = true,
    italic = false,
    transparency = true
  },


  highlight_groups = {
    Visual                  = { fg = "base", bg = "iris" },
    Cursor                  = { fg = "base", bg = "pine" },
    CursorColumn            = { fg = "base", bg = "gold" },
    ColorColumn             = { fg = "base", bg = "gold" },
    CursorLine              = { bg = "muted", blend = 20 },
    LineNr                  = { fg = "iris", bg = "none" },
    CursorLineNr            = { fg = "base", bg = "love" },
    IncSearch               = { fg = "base", bg = "love" },
    Normal                  = { bg = "none" },
    NormalFloat             = { bg = "none" },
    NormalNC                = { bg = "none" },
    FloatBorder             = { fg = "gold", bg = "none" },
    StatusLine              = { fg = "love", bg = "muted", blend = 20 },
    StatusLineNC            = { fg = "rose", bg = "muted", blend = 20 },
    TelescopeBorder         = { fg = "gold", bg = "none" },
    TelescopeNormal         = { fg = "text", bg = "none" },
    TelescopePromptNormal   = { bg = "none" },
    TelescopeResultsNormal  = { fg = "text", bg = "none" },
    TelescopeSelection      = { fg = "love", bg = "muted", blend = 20 },
    TelescopeSelectionCaret = { fg = "rose", bg = "muted", blend = 20 },
    TelescopePromptBorder   = { fg = "gold", bg = "none" },

    TelescopeTitle          = { fg = "text", bg = "none" },
    TelescopePromptTitle    = { fg = "text", bg = "none" },
    TelescopePreviewTitle   = { fg = "text", bg = "none" },

  },
})



vim.cmd([[colorscheme rose-pine]])

local highlights = require('rose-pine.plugins.bufferline')
require('bufferline').setup({ highlights = highlights })
