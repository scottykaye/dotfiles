return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()

    vim.keymap.set("n", "<leader>cm", ":Mason<CR>", { noremap = true, silent = true })
  end
}
