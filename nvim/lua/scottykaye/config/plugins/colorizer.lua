require('colorizer').setup({
  filetypes = {
    'css',
    'javascript',
    'tsx',
    'ts',
    'html'
  },
  user_default_options = {
    mode = 'background', -- Default mode for all filetypes
    rgb_fn = true,       -- Enable parsing rgb(...) functions
    names = false,       -- Disable parsing color names like "red"
  },
})
