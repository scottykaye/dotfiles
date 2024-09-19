local wk = require("which-key")
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set('n', '<leader>kh', builtin.help_tags, {})

wk.add({
  { "<leader>f",   group = "file" }, -- group
  { "<leader>ff",  "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  { "<leader>fnn", desc = "New File" },
  {
    "<leader>b",
    group = "buffers",
    expand = function()
      return require("which-key.extras").expand.buf()
    end
  },
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n", "v" },                          -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  }
})
