require("match").setup({})

vim.keymap.set("n", "<leader>ma", ":Match<CR>", { desc = "Match: Search and Replace" })
vim.keymap.set("n", "<leader>mw", ":MatchWord<CR>", { desc = "Match: Word under cursor" })
vim.keymap.set("n", "<leader>ml", ":MatchLine<CR>", { desc = "Match: Current line" })
