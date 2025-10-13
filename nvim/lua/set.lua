-- vim.opt.guicursor = ""
vim.opt.number = true
-- vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

-- vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.clipboard = "unnamedplus"
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

vim.opt.laststatus = 2 -- Or 3 for global statusline
-- vim.opt.statusline = " %f %m %= %l:%c ♥ "
vim.opt.showmode = true
vim.opt.showcmd = true
-- vim.opt.guicursor="n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
vim.opt.guicursor = 'n-v-c:block-Cursor/lCursor'
vim.opt.cursorline = true
--  vim.opt.guicursor = ""
vim.o.hlsearch = true



-- vim.opt.colorcolumn = "80"

-- vim.api.nvim_command([[
--  autocmd BufWritePre *.lua :lua require("my_module").strip_trailing_whitespace()
-- ]])

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
