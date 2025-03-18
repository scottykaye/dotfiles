vim.cmd([[highlight RainbowBracket1 guifg=#fed62f gui=nocombine]])
vim.cmd([[highlight RainbowBracket2 guifg=#eb6f92 gui=nocombine]])
vim.cmd([[highlight RainbowBracket3 guifg=#c4a7e7 gui=nocombine]])
vim.cmd([[highlight RainbowBracket4 guifg=#3e8fb0 gui=nocombine]])

-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
  strategy = {
    -- Use global strategy by default
    [''] = rainbow_delimiters.strategy['global'],
    -- Use local strategy
    vim = rainbow_delimiters.strategy['local'],
    html = rainbow_delimiters.strategy['local'],
    htmldjango = rainbow_delimiters.strategy['local'],
  },
  query = {
    -- Use parentheses by default
    [''] = 'rainbow-delimiters',
    -- Use blocks for Lua
    lua = 'rainbow-blocks',
  },
  highlight = {
    'RainbowBracket1',
    'RainbowBracket2',
    'RainbowBracket3',
    'RainbowBracket4',
  },
}
