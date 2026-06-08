require("match").setup({})

vim.keymap.set("n", "<leader>ma", ":Match<CR>")
vim.keymap.set("n", "<leader>mw", ":MatchWord<CR>")
vim.keymap.set("n", "<leader>ml", ":MatchLine<CR>")
