local wk = require("which-key")
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set('n', '<leader>kh', builtin.help_tags, {})

wk.register({
  -- Don't really need this I do it with leader pf
  --  f = { "<cmd>Telescope find_files<cr>", "Find Files" },
  R = { "<cmd>Telescope live_grep<cr>", "ripgrep" },
  H = { "<cmd>Telescope help_tags<cr>", "Help" },
}, { prefix = "<leader>" })
