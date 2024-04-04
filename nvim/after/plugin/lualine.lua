require("lualine").setup({
  sections = {
    lualine_c = { { 'filename', path = 2 } }
  },
  inactive_sections = {
    lualine_c = { { 'filename', path = 2 } }
  },
  options = {
    theme = "rose-pine",
    -- theme = "dracula",
    -- theme = "catppuccin",
  },
})
