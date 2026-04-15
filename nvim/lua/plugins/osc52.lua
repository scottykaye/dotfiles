local osc52 = require('osc52')

-- override yank to also copy to macOS clipboard via OSC52
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
      osc52.copy_register('')
    end
  end,
})
