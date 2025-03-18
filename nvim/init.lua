
-- Make sure to setup `mapleader` and `maplocalleader` in the remap before
require("remap")
require("set")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
	vim.api.nvim_echo({
	    { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
	    { out, "WarningMsg" },
	    { "\nPress any key to exit..." },
	}, true, {})
	vim.fn.getchar()
	os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy.nvim with the plugins directory
local opts = {
  ui = {
    size = { width = 0.8, height = 0.8 },
    border = "rounded",
    backdrop = 100,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      paths = {}, -- custom paths to include in the rtp
      disabled_plugins = {
	"gzip",
	"netrwPlugin",
	"tarPlugin",
	"tohtml",
	"tutor",
	"zipPlugin",
      },
    },
  },
}

-- Lazy.nvim will automatically look for all plugins in the 'plugins' directory
require("lazy").setup("plugins", opts)
