require("toggleterm").setup({
  open_mapping = [[<C-S-T>]],
})

local highlights = require('rose-pine.plugins.toggleterm')
require('toggleterm').setup({ highlights = highlights })
