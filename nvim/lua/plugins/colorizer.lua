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

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    require("colorizer").attach_to_buffer(0)
  end,
})
