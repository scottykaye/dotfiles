vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- remap vim paste to paste copy
vim.keymap.set("v", "<leader>pc", "p")
-- make pastes actually paste
vim.keymap.set("v", "p", "pgvy")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
  require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
  require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Remapping for yanking
-- This remaps <leader>y in normal (n) and visual (v) modes to "+y, which yanks (copies) the selected text to the system clipboard ("+ refers to the system clipboard register in Vim).
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- This remaps <leader>Y in normal (n) mode to "+Y, which yanks (copies) the entire line to the system clipboard.
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- This remaps <leader>d in normal (n) and visual (v) modes to "_d, which deletes the selected text to the black hole register ("_ refers to the black hole register in Vim).
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- Use Ctrl c to close insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>c", [[:nohlsearch<CR>]])

-- vim.keymap.set("n", "<S-M-Up>", "Vypk")
-- vim.keymap.set("n", "<S-M-Down>", "Vyp")
-- vim.keymap.set("i", "<S-M-Up>", "<Esc>Vypk")
-- vim.keymap.set("i", "<S-M-Down>", "<Esc>Vyp")
--
-- vim.keymap.set("n", "<M-Up>", "Vyddkkp")
-- vim.keymap.set("n", "<M-Down>", "Vyddp")
-- vim.keymap.set("i", "<M-Up>", "<Esc>Vyddkkp")
-- vim.keymap.set("i", "<M-Down>", "<Esc>Vyddp")

vim.keymap.set("n", "<M-Down>", ":m .+1<CR>==")
vim.keymap.set("n", "<M-Up>", ":m .-2<CR>==")
vim.keymap.set("n", "<S-M-Down>", ":t.<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-M-Up>", ":t-1<CR>", { noremap = true, silent = true })

-- Move/duplicate lines up and down (insert mode)
vim.keymap.set("i", "<M-Down>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<M-Up>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "<S-M-Down>", "<C-o>:t.<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<S-M-Up>", "<C-o>:t-1<CR>", { noremap = true, silent = true })

-- Move/duplicate lines up and down (visual mode)
vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<S-M-Down>", ":t-1<CR>gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-M-Up>", ":t'><CR>gv", { noremap = true, silent = true })

-- Move/duplicate lines up and down (normal mode)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("n", "<A-J>", ":t.<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-K>", ":t-1<CR>", { noremap = true, silent = true })

-- Move/duplicate lines up and down (insert mode)
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "<A-J>", "<C-o>:t.<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<A-K>", "<C-o>:t-1<CR>", { noremap = true, silent = true })

-- Move/duplicate lines up and down (visual mode)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-J>", ":t-1<CR>gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-K>", ":t'><CR>gv", { noremap = true, silent = true })



vim.keymap.set("n", "<leader>w", [[:w<CR>]])
vim.keymap.set("n", "<leader>W", [[:w<CR>]])
vim.keymap.set("n", "<leader>h", [[:/<C-r><C-w><CR>]])
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>ok", [[:%s/\(.*\)/bar\1/g<Left><Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)


-- open file_browser with the path of the current buffer
-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>fb",
--   ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
--   { noremap = true }
-- )


vim.api.nvim_create_user_command("Cpath", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied relative path "' .. path .. '" to the clipboard!')
end, {})



vim.api.nvim_create_user_command("Capath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied absolute path "' .. path .. '" to the clipboard!')
end, {})
