require("dracula").setup({
  colors = {
    bg = "none",
    fg = "#F8F8F2",
    selection = "#44475A",
    comment = "#6272A4",
    red = "#FF5555",
    orange = "#FFB86C",
    yellow = "#F1FA8C",
    orange_yellow = "#ffeb20",
    green = "#50fa7b",
    purple = "#BD93F9",
    cyan = "#8BE9FD",
    --   original is directly below
    --   pink = "#FF79C6",
    --   pink = "#FF3884",
    --   pink = "#FF34A3",
    pink = "#FF37BA",
    bright_red = "#FF6E6E",
    bright_green = "#69FF94",
    bright_yellow = "#FFFFA5",
    bright_blue = "#D6ACFF",
    -- original is directly below
    -- bright_magenta = "#FF92DF",
    bright_magenta = "#FF79c6",
    bright_cyan = "#A4FFFF",
    bright_white = "#FFFFFF",
    menu = "#21222C",
    visual = "#3E4452",
    gutter_fg = "#4B5263",
    nontext = "#3B4048",
    white = "#ABB2BF",
    black = "#191A21",
  },
  show_end_of_buffer = true,          -- default false
  transparent_bg = true,              -- default false
  lualine_bg_color = "#44475a",       -- default nil
  italic_comment = true,              -- default false

  overrides = function(colors)
    return {

      FloatBorder = { fg = colors.orange_yellow, },
      NonText = { fg = colors.white },       -- set NonText fg to white of theme
      DiffAdd = { bg = colors.bright_green },
      DiffDelete = { fg = colors.bright_red },
      DiffChange = { bg = colors.comment },
      DiffText = { bg = colors.comment },

      Cursor = { reverse = true, },
      CursorLineNr = { fg = colors.black, bg = colors.orange_yellow, bold = true, },
      SignColumn = { bg = colors.bg, },
      Conceal = { fg = colors.comment, },
      CursorColumn = { fg = colors.black, bg = colors.bright_yellow, },
      CursorLine = { bg = colors.selection, },
      ColorColumn = { bg = colors.bright_yellow },
      Directory = { fg = colors.purple, },

      ErrorMsg = { fg = colors.bright_red, },

      VertSplit = { fg = colors.pink, },
      WinSeparator = { fg = colors.pink, },
      Folded = { fg = colors.comment, },
      FoldColumn = {},
      Search = { fg = colors.black, bg = colors.bright_magenta, },
      IncSearch = { fg = colors.bright_green, bg = colors.comment, },
      LineNr = { fg = colors.white, },
      MatchParen = { fg = colors.fg, underline = true, },
      Pmenu = { fg = colors.white, bg = colors.menu, },
      PmenuSel = { fg = colors.white, bg = colors.selection, },
      PmenuSbar = { bg = colors.bg, },
      PmenuThumb = { bg = colors.selection, },
      illuminatedWord = { bg = colors.comment },

      illuminatedCurWord = { bg = colors.comment },
      IlluminatedWordText = { bg = colors.comment },
      IlluminatedWordRead = { bg = colors.comment },
      IlluminatedWordWrite = { bg = colors.comment },

      StatusLine = { fg = colors.black, bg = colors.orange_yellow, bold = true },
      StatusLineNC = { fg = colors.black, bg = colors.white },
      StatusLineTerm = { fg = colors.white, bg = colors.pink },
      StatusLineTermNC = { fg = colors.comment, },

      TelescopePromptBorder = { fg = colors.bright_green, },
      TelescopeResultsBorder = { fg = colors.bright_green, },
      TelescopePreviewBorder = { fg = colors.bright_green },
      TelescopeSelection = { fg = colors.bright_green, bg = colors.selection, },
      TelescopeMultiSelection = { fg = colors.purple, bg = colors.selection, },
      TelescopeNormal = { fg = colors.white, bg = colors.bg },
      TelescopeMatching = { fg = colors.bright_green, },
      TelescopePromptPrefix = { fg = colors.purple, },
      TelescopeResultsDiffDelete = { fg = colors.red },
      TelescopeResultsDiffChange = { fg = colors.cyan },
      TelescopeResultsDiffAdd = { fg = colors.green },

      markdownBlockquote = { fg = colors.yellow, italic = true, },
      markdownBold = { fg = colors.orange, bold = true, },
      markdownCode = { fg = colors.green, },
      markdownCodeBlock = { fg = colors.orange, },
      markdownCodeDelimiter = { fg = colors.red, },
      markdownH1 = { fg = colors.pink, bold = true, },
      markdownH2 = { fg = colors.pink, bold = true, },
      markdownH3 = { fg = colors.pink, bold = true, },
      markdownH4 = { fg = colors.pink, bold = true, },
      markdownH5 = { fg = colors.pink, bold = true, },
      markdownH6 = { fg = colors.pink, bold = true, },
      markdownHeadingDelimiter = { fg = colors.red, },
      markdownHeadingRule = { fg = colors.comment, },
      markdownId = { fg = colors.purple, },
      markdownIdDeclaration = { fg = colors.cyan, },
      markdownIdDelimiter = { fg = colors.purple, },
      markdownItalic = { fg = colors.yellow, italic = true, },
      markdownLinkDelimiter = { fg = colors.purple, },
      markdownLinkText = { fg = colors.pink, },
      markdownListMarker = { fg = colors.cyan, },
      markdownOrderedListMarker = { fg = colors.red, },
      markdownRule = { fg = colors.comment, },


    }
  end
})

vim.cmd([[colorscheme dracula]])
