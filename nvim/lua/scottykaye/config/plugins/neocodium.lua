local neocodeium = require("neocodeium")
neocodeium.setup()
vim.keymap.set("i", "<C-f>", neocodeium.accept)
