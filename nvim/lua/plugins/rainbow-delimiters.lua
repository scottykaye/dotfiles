local rainbow_delimiters = require 'rainbow-delimiters'

-- Custom Rose Pine themed colors
vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#fed62f' }) -- gold
vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#eb6f92' })    -- love/rose
vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#c4a7e7' }) -- iris
vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#3e8fb0' })   -- pine

-- Re-apply on colorscheme change
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#fed62f' })
    vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#eb6f92' })
    vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#c4a7e7' })
    vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#3e8fb0' })
  end,
})

vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    vim = rainbow_delimiters.strategy['local'],
    html = rainbow_delimiters.strategy['local'],
    htmldjango = rainbow_delimiters.strategy['local'],
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  highlight = {
    'RainbowDelimiterYellow',
    'RainbowDelimiterRed',
    'RainbowDelimiterViolet',
    'RainbowDelimiterBlue',
  },
}
