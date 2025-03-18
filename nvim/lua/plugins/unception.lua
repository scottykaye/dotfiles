return {
  "samjwill/nvim-unception",
    dependencies = { "numToStr/FTerm.nvim" },
    init = function()
      vim.g.unception_open_buffer_in_new_tab = true
    end,
  config = function()
    require("unception").setup()

    vim.api.nvim_create_autocmd("User", {
      pattern = "UnceptionEditRequestReceived",
      callback = function()
        require("FTerm").toggle()
      end,
    })

    vim.keymap.set("n", "<leader>u", ":UnceptionToggle<CR>", { desc = "Toggle Unception" })
  end
}
