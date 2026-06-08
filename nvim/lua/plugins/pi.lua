require("pi").setup({
  binary = "~/.bin/pi", -- or { "env", "FOO=1", "pi-wrapper" }
  provider = "openrouter",
  model = "openrouter/free",
  thinking = "off", -- be careful, thinking is time-consuming, it's not a great experience if you want simplicity
  system_prompt = "You are a helpful assistant.",
  append_system_prompt = "Always respond concisely.",
  context = {
    max_bytes = 24000,
    ask = {
      surrounding_lines = 80,
    },
    selection = {
      surrounding_lines = 40,
    },
    diagnostics = {
      enabled = false,
    },
  },
  skills = true,
  extensions = true,
})

vim.keymap.set("n", "<leader>ai", ":PiAsk<CR>", { desc = "Ask pi" })
vim.keymap.set("v", "<leader>ai", ":PiAskSelection<CR>", { desc = "Ask pi (selection)" })
