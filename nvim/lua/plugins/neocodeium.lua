return {
    "monkoose/neocodeium",
    event = "VeryLazy",
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup()

    vim.keymap.set("i", "<C-f>", neocodeium.accept)
    vim.keymap.set("i", "<A-f>", neocodeium.accept)
    vim.keymap.set("i", "<A-w>", neocodeium.accept_word)
    vim.keymap.set("i", "<A-a>", neocodeium.accept_line)
    vim.keymap.set("i", "<A-e>", neocodeium.cycle_or_complete)
    vim.keymap.set("i", "<A-r>", neocodeium.cycle_or_complete)
    vim.keymap.set("i", "<A-c>", neocodeium.clear)
  end
}
