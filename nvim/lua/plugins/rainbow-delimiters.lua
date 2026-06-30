-- Custom Rose Pine themed colors for rainbow brackets
local function set_colors()
  vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#fed62f' }) -- gold
  vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#eb6f92' })    -- love/rose
  vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#c4a7e7' }) -- iris
  vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#3e8fb0' })   -- pine
end

set_colors()

-- Re-apply on colorscheme change
vim.api.nvim_create_autocmd('ColorScheme', { callback = set_colors })

-- Use the plugin's default strategy/query (most reliable), just override the
-- highlight cycle with our colors. Custom per-language `query` values like
-- 'rainbow-blocks' only highlight do/end-style blocks, NOT brackets, which is
-- a common reason brackets appear uncolored.
vim.g.rainbow_delimiters = {
  highlight = {
    'RainbowDelimiterYellow',
    'RainbowDelimiterRed',
    'RainbowDelimiterViolet',
    'RainbowDelimiterBlue',
  },
}
