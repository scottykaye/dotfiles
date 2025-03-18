return {
  "dstein64/nvim-scrollview",
  config = function()
    require("scrollbar").setup()

    -- Optional: Customize key mappings (if needed)
   vim.keymap.set("n", "<leader>ss", ":ScrollbarToggle<CR>", { desc = "Toggle Scrollbar" })
  end
}
