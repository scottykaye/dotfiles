vim.defer_fn(function()
  vim.cmd("ShowkeysToggle")
end, 100)
vim.keymap.set("n", "<leader>sk", [[:ShowkeysToggle<CR>]])
