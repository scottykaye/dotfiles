-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/scottkaye/.cache/nvim/packer_hererocks/2.1.1703358377/share/lua/5.1/?.lua;/Users/scottkaye/.cache/nvim/packer_hererocks/2.1.1703358377/share/lua/5.1/?/init.lua;/Users/scottkaye/.cache/nvim/packer_hererocks/2.1.1703358377/lib/luarocks/rocks-5.1/?.lua;/Users/scottkaye/.cache/nvim/packer_hererocks/2.1.1703358377/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/scottkaye/.cache/nvim/packer_hererocks/2.1.1703358377/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\nT\0\0\4\0\3\0\a5\0\0\0006\1\1\0009\1\2\1\21\3\0\0B\1\2\0028\1\1\0L\1\2\0\vrandom\tmath\1\5\0\0\vString\15Identifier\fKeyword\vNumber�\1\0\0\t\0\14\0\0266\0\0\0009\0\1\0006\2\2\0B\0\2\2\21\0\0\0006\1\3\0009\1\4\1'\3\5\0B\1\2\0026\2\0\0009\2\6\2B\2\1\2'\3\a\0009\4\b\2'\5\t\0009\6\n\2'\a\t\0009\b\v\2&\3\b\3\18\4\1\0'\5\f\0\18\6\0\0'\a\r\0\18\b\3\0&\4\b\4L\4\2\0\r plugins\v   \npatch\nminor\6.\nmajor\f   v\fversion\31 %d-%m-%Y   %H:%M:%S\tdate\aos\19packer_plugins\rtbl_keys\bvim�\f\1\0\f\0$\1M6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\3\0009\2\4\0026\4\5\0009\4\6\4B\4\1\0A\2\0\0013\2\a\0003\3\b\0005\4\t\0009\5\n\0019\5\v\5=\4\f\0059\5\n\0019\5\v\0059\5\r\5\18\6\2\0B\6\1\2=\6\14\0059\5\n\0019\5\15\0054\6\a\0009\a\16\1'\t\17\0'\n\18\0B\a\3\2>\a\1\0069\a\16\1'\t\19\0'\n\20\0B\a\3\2>\a\2\0069\a\16\1'\t\21\0'\n\22\0B\a\3\2>\a\3\0069\a\16\1'\t\23\0'\n\24\0B\a\3\2>\a\4\0069\a\16\1'\t\25\0'\n\26\0B\a\3\2>\a\5\0069\a\16\1'\t\27\0'\n\28\0'\v\29\0B\a\4\0?\a\0\0=\6\f\0059\5\n\0019\5\30\5\18\6\3\0B\6\1\2=\6\f\0059\5\n\0019\5\30\0059\5\r\5'\6\31\0=\6\14\0059\5 \0009\a\r\1B\5\2\0016\5!\0009\5\"\5'\a#\0B\5\2\1K\0\1\0003 autocmd FileType alpha setlocal nofoldenable \bcmd\bvim\nsetup\rConstant\vfooter\f:qa<cr>\14  Quit\6q\24  Update plugins\16<leader>vpp\24  Project Search\15<leader>ps\30  Recent Project Files\n<C-e>\19  Find File\15<leader>pf\22  File Browser\15<leader>fb\vbutton\fbuttons\ahl\topts\bval\vheader\fsection\1\t\0\0:                                                     �\1  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ �\1  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ �\1  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ �\1  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ �\1  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ �\1  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ :                                                     \0\0\ttime\aos\15randomseed\tmath\27alpha.themes.dashboard\nalpha\frequire\r����\4\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/opt/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["cellular-automaton.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/cellular-automaton.nvim",
    url = "https://github.com/eandrju/cellular-automaton.nvim"
  },
  ["cloak.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/cloak.nvim",
    url = "https://github.com/laytan/cloak.nvim"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["conform.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fconform\frequire\0" },
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/conform.nvim",
    url = "https://github.com/stevearc/conform.nvim"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  dracula = {
    config = { "\27LJ\2\n�\20\0\1\4\0�\1\0�\0025\1\3\0005\2\1\0009\3\0\0=\3\2\2=\2\4\0015\2\6\0009\3\5\0=\3\2\2=\2\a\0015\2\t\0009\3\b\0=\3\n\2=\2\v\0015\2\r\0009\3\f\0=\3\2\2=\2\14\0015\2\16\0009\3\15\0=\3\n\2=\2\17\0015\2\18\0009\3\15\0=\3\n\2=\2\19\0015\2\20\0=\2\21\0015\2\23\0009\3\22\0=\3\2\0029\3\0\0=\3\n\2=\2\24\0015\2\25\0009\3\n\0=\3\n\2=\2\26\0015\2\27\0009\3\15\0=\3\2\2=\2\28\0015\2\29\0009\3\22\0=\3\2\0029\3\30\0=\3\n\2=\2\31\0015\2!\0009\3 \0=\3\n\2=\2\"\0015\2#\0009\3\30\0=\3\n\2=\2$\0015\2&\0009\3%\0=\3\2\2=\2'\0015\2(\0009\3\f\0=\3\2\2=\2)\0015\2+\0009\3*\0=\3\2\2=\2,\0015\2-\0009\3*\0=\3\2\2=\2.\0015\2/\0009\3\15\0=\3\2\2=\0020\0014\2\0\0=\0021\0015\0022\0009\3\22\0=\3\2\0029\0033\0=\3\n\2=\0024\0015\0025\0009\3\b\0=\3\2\0029\3\15\0=\3\n\2=\0026\0015\0027\0009\3\5\0=\3\2\2=\0028\0015\0029\0009\3\2\0=\3\2\2=\2:\0015\2;\0009\3\5\0=\3\2\0029\3<\0=\3\n\2=\2=\0015\2>\0009\3\5\0=\3\2\0029\3 \0=\3\n\2=\2?\0015\2@\0009\3\n\0=\3\n\2=\2A\0015\2B\0009\3 \0=\3\n\2=\2C\0015\2D\0009\3\15\0=\3\n\2=\2E\0015\2F\0009\3\15\0=\3\n\2=\2G\0015\2H\0009\3\15\0=\3\n\2=\2I\0015\2J\0009\3\15\0=\3\n\2=\2K\0015\2L\0009\3\15\0=\3\n\2=\2M\0015\2N\0009\3\22\0=\3\2\0029\3\0\0=\3\n\2=\2O\0015\2P\0009\3\22\0=\3\2\0029\3\5\0=\3\n\2=\2Q\0015\2R\0009\3\5\0=\3\2\0029\3*\0=\3\n\2=\2S\0015\2T\0009\3\15\0=\3\2\2=\2U\0015\2V\0009\3\b\0=\3\2\2=\2W\0015\2X\0009\3\b\0=\3\2\2=\2Y\0015\2Z\0009\3\b\0=\3\2\2=\2[\0015\2\\\0009\3\b\0=\3\2\0029\3 \0=\3\n\2=\2]\0015\2^\0009\3%\0=\3\2\0029\3 \0=\3\n\2=\2_\0015\2`\0009\3\5\0=\3\2\0029\3\n\0=\3\n\2=\2a\0015\2b\0009\3\b\0=\3\2\2=\2c\0015\2d\0009\3%\0=\3\2\2=\2e\0015\2g\0009\3f\0=\3\2\2=\2h\0015\2j\0009\3i\0=\3\2\2=\2k\0015\2m\0009\3l\0=\3\2\2=\2n\0015\2p\0009\3o\0=\3\2\2=\2q\0015\2s\0009\3r\0=\3\2\2=\2t\0015\2u\0009\3l\0=\3\2\2=\2v\0015\2w\0009\3r\0=\3\2\2=\2x\0015\2y\0009\3f\0=\3\2\2=\2z\0015\2{\0009\3*\0=\3\2\2=\2|\0015\2}\0009\3*\0=\3\2\2=\2~\0015\2\127\0009\3*\0=\3\2\2=\2�\0015\2�\0009\3*\0=\3\2\2=\2�\0015\2�\0009\3*\0=\3\2\2=\2�\0015\2�\0009\3*\0=\3\2\2=\2�\0015\2�\0009\3f\0=\3\2\2=\2�\0015\2�\0009\3\15\0=\3\2\2=\2�\0015\2�\0009\3%\0=\3\2\2=\2�\0015\2�\0009\3i\0=\3\2\2=\2�\0015\2�\0009\3%\0=\3\2\2=\2�\0015\2�\0009\3o\0=\3\2\2=\2�\0015\2�\0009\3%\0=\3\2\2=\2�\0015\2�\0009\3*\0=\3\2\2=\2�\0015\2�\0009\3i\0=\3\2\2=\2�\0015\2�\0009\3f\0=\3\2\2=\2�\0015\2�\0009\3\15\0=\3\2\2=\2�\1L\1\2\0\17markdownRule\1\0\0\30markdownOrderedListMarker\1\0\0\23markdownListMarker\1\0\0\21markdownLinkText\1\0\0\26markdownLinkDelimiter\1\0\0\19markdownItalic\1\0\1\vitalic\2\24markdownIdDelimiter\1\0\0\26markdownIdDeclaration\1\0\0\15markdownId\1\0\0\24markdownHeadingRule\1\0\0\29markdownHeadingDelimiter\1\0\0\15markdownH6\1\0\1\tbold\2\15markdownH5\1\0\1\tbold\2\15markdownH4\1\0\1\tbold\2\15markdownH3\1\0\1\tbold\2\15markdownH2\1\0\1\tbold\2\15markdownH1\1\0\1\tbold\2\26markdownCodeDelimiter\1\0\0\22markdownCodeBlock\1\0\0\17markdownCode\1\0\0\17markdownBold\1\0\1\tbold\2\vorange\23markdownBlockquote\1\0\1\vitalic\2\vyellow\28TelescopeResultsDiffAdd\1\0\0\ngreen\31TelescopeResultsDiffChange\1\0\0\tcyan\31TelescopeResultsDiffDelete\1\0\0\bred\26TelescopePromptPrefix\1\0\0\22TelescopeMatching\1\0\0\20TelescopeNormal\1\0\0\28TelescopeMultiSelection\1\0\0\23TelescopeSelection\1\0\0\27TelescopePreviewBorder\1\0\0\27TelescopeResultsBorder\1\0\0\26TelescopePromptBorder\1\0\0\21StatusLineTermNC\1\0\0\19StatusLineTerm\1\0\0\17StatusLineNC\1\0\0\15StatusLine\1\0\1\tbold\2\25IlluminatedWordWrite\1\0\0\24IlluminatedWordRead\1\0\0\24IlluminatedWordText\1\0\0\23illuminatedCurWord\1\0\0\20illuminatedWord\1\0\0\15PmenuThumb\1\0\0\14PmenuSbar\1\0\0\rPmenuSel\1\0\0\nPmenu\tmenu\1\0\0\15MatchParen\1\0\1\14underline\2\vLineNr\1\0\0\14IncSearch\1\0\0\vSearch\19bright_magenta\1\0\0\15FoldColumn\vFolded\1\0\0\17WinSeparator\1\0\0\14VertSplit\1\0\0\tpink\rErrorMsg\1\0\0\14Directory\1\0\0\vpurple\16ColorColumn\1\0\0\15CursorLine\1\0\0\14selection\17CursorColumn\18bright_yellow\1\0\0\fConceal\1\0\0\15SignColumn\1\0\0\17CursorLineNr\1\0\1\tbold\2\nblack\vCursor\1\0\1\freverse\2\rDiffText\1\0\0\15DiffChange\1\0\0\fcomment\15DiffDelete\1\0\0\15bright_red\fDiffAdd\abg\1\0\0\17bright_green\fNonText\1\0\0\nwhite\16FloatBorder\1\0\0\afg\1\0\0\18orange_yellow�\4\1\0\4\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0023\3\6\0=\3\a\2B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0\24colorscheme dracula\bcmd\bvim\14overrides\0\vcolors\1\0\4\19italic_comment\2\21lualine_bg_color\f#44475a\19transparent_bg\2\23show_end_of_buffer\2\1\0\25\fcomment\f#6272A4\afg\f#F8F8F2\vyellow\f#F1FA8C\17bright_green\f#69FF94\tcyan\f#8BE9FD\19bright_magenta\f#FF79c6\16bright_cyan\f#A4FFFF\tmenu\f#21222C\tpink\f#FF37BA\nwhite\f#ABB2BF\18orange_yellow\f#ffeb20\vvisual\f#3E4452\vorange\f#FFB86C\nblack\f#191A21\14selection\f#44475A\fnontext\f#3B4048\14gutter_fg\f#4B5263\17bright_white\f#FFFFFF\abg\tnone\ngreen\f#50fa7b\bred\f#FF5555\vpurple\f#BD93F9\16bright_blue\f#D6ACFF\18bright_yellow\f#FFFFA5\15bright_red\f#FF6E6E\nsetup\fdracula\frequire\0" },
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/dracula",
    url = "https://github.com/Mofiqul/dracula.nvim"
  },
  ["dressing.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["git-blame.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/git-blame.nvim",
    url = "https://github.com/f-person/git-blame.nvim"
  },
  ["glance.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/glance.nvim",
    url = "https://github.com/dnlhc/glance.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/NvChad/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["prettier.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/prettier.nvim",
    url = "https://github.com/MunifTanjim/prettier.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\nT\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\17open_mapping\f<C-S-T>\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  undotree = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\np\0\0\3\0\a\0\0146\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0)\1,\1=\1\3\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0B\0\1\1K\0\1\0\nsetup\14which-key\frequire\15timeoutlen\ftimeout\6o\bvim\0" },
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    loaded = true,
    path = "/Users/scottkaye/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\np\0\0\3\0\a\0\0146\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0)\1,\1=\1\3\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0B\0\1\1K\0\1\0\nsetup\14which-key\frequire\15timeoutlen\ftimeout\6o\bvim\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: dracula
time([[Config for dracula]], true)
try_loadstring("\27LJ\2\n�\20\0\1\4\0�\1\0�\0025\1\3\0005\2\1\0009\3\0\0=\3\2\2=\2\4\0015\2\6\0009\3\5\0=\3\2\2=\2\a\0015\2\t\0009\3\b\0=\3\n\2=\2\v\0015\2\r\0009\3\f\0=\3\2\2=\2\14\0015\2\16\0009\3\15\0=\3\n\2=\2\17\0015\2\18\0009\3\15\0=\3\n\2=\2\19\0015\2\20\0=\2\21\0015\2\23\0009\3\22\0=\3\2\0029\3\0\0=\3\n\2=\2\24\0015\2\25\0009\3\n\0=\3\n\2=\2\26\0015\2\27\0009\3\15\0=\3\2\2=\2\28\0015\2\29\0009\3\22\0=\3\2\0029\3\30\0=\3\n\2=\2\31\0015\2!\0009\3 \0=\3\n\2=\2\"\0015\2#\0009\3\30\0=\3\n\2=\2$\0015\2&\0009\3%\0=\3\2\2=\2'\0015\2(\0009\3\f\0=\3\2\2=\2)\0015\2+\0009\3*\0=\3\2\2=\2,\0015\2-\0009\3*\0=\3\2\2=\2.\0015\2/\0009\3\15\0=\3\2\2=\0020\0014\2\0\0=\0021\0015\0022\0009\3\22\0=\3\2\0029\0033\0=\3\n\2=\0024\0015\0025\0009\3\b\0=\3\2\0029\3\15\0=\3\n\2=\0026\0015\0027\0009\3\5\0=\3\2\2=\0028\0015\0029\0009\3\2\0=\3\2\2=\2:\0015\2;\0009\3\5\0=\3\2\0029\3<\0=\3\n\2=\2=\0015\2>\0009\3\5\0=\3\2\0029\3 \0=\3\n\2=\2?\0015\2@\0009\3\n\0=\3\n\2=\2A\0015\2B\0009\3 \0=\3\n\2=\2C\0015\2D\0009\3\15\0=\3\n\2=\2E\0015\2F\0009\3\15\0=\3\n\2=\2G\0015\2H\0009\3\15\0=\3\n\2=\2I\0015\2J\0009\3\15\0=\3\n\2=\2K\0015\2L\0009\3\15\0=\3\n\2=\2M\0015\2N\0009\3\22\0=\3\2\0029\3\0\0=\3\n\2=\2O\0015\2P\0009\3\22\0=\3\2\0029\3\5\0=\3\n\2=\2Q\0015\2R\0009\3\5\0=\3\2\0029\3*\0=\3\n\2=\2S\0015\2T\0009\3\15\0=\3\2\2=\2U\0015\2V\0009\3\b\0=\3\2\2=\2W\0015\2X\0009\3\b\0=\3\2\2=\2Y\0015\2Z\0009\3\b\0=\3\2\2=\2[\0015\2\\\0009\3\b\0=\3\2\0029\3 \0=\3\n\2=\2]\0015\2^\0009\3%\0=\3\2\0029\3 \0=\3\n\2=\2_\0015\2`\0009\3\5\0=\3\2\0029\3\n\0=\3\n\2=\2a\0015\2b\0009\3\b\0=\3\2\2=\2c\0015\2d\0009\3%\0=\3\2\2=\2e\0015\2g\0009\3f\0=\3\2\2=\2h\0015\2j\0009\3i\0=\3\2\2=\2k\0015\2m\0009\3l\0=\3\2\2=\2n\0015\2p\0009\3o\0=\3\2\2=\2q\0015\2s\0009\3r\0=\3\2\2=\2t\0015\2u\0009\3l\0=\3\2\2=\2v\0015\2w\0009\3r\0=\3\2\2=\2x\0015\2y\0009\3f\0=\3\2\2=\2z\0015\2{\0009\3*\0=\3\2\2=\2|\0015\2}\0009\3*\0=\3\2\2=\2~\0015\2\127\0009\3*\0=\3\2\2=\2�\0015\2�\0009\3*\0=\3\2\2=\2�\0015\2�\0009\3*\0=\3\2\2=\2�\0015\2�\0009\3*\0=\3\2\2=\2�\0015\2�\0009\3f\0=\3\2\2=\2�\0015\2�\0009\3\15\0=\3\2\2=\2�\0015\2�\0009\3%\0=\3\2\2=\2�\0015\2�\0009\3i\0=\3\2\2=\2�\0015\2�\0009\3%\0=\3\2\2=\2�\0015\2�\0009\3o\0=\3\2\2=\2�\0015\2�\0009\3%\0=\3\2\2=\2�\0015\2�\0009\3*\0=\3\2\2=\2�\0015\2�\0009\3i\0=\3\2\2=\2�\0015\2�\0009\3f\0=\3\2\2=\2�\0015\2�\0009\3\15\0=\3\2\2=\2�\1L\1\2\0\17markdownRule\1\0\0\30markdownOrderedListMarker\1\0\0\23markdownListMarker\1\0\0\21markdownLinkText\1\0\0\26markdownLinkDelimiter\1\0\0\19markdownItalic\1\0\1\vitalic\2\24markdownIdDelimiter\1\0\0\26markdownIdDeclaration\1\0\0\15markdownId\1\0\0\24markdownHeadingRule\1\0\0\29markdownHeadingDelimiter\1\0\0\15markdownH6\1\0\1\tbold\2\15markdownH5\1\0\1\tbold\2\15markdownH4\1\0\1\tbold\2\15markdownH3\1\0\1\tbold\2\15markdownH2\1\0\1\tbold\2\15markdownH1\1\0\1\tbold\2\26markdownCodeDelimiter\1\0\0\22markdownCodeBlock\1\0\0\17markdownCode\1\0\0\17markdownBold\1\0\1\tbold\2\vorange\23markdownBlockquote\1\0\1\vitalic\2\vyellow\28TelescopeResultsDiffAdd\1\0\0\ngreen\31TelescopeResultsDiffChange\1\0\0\tcyan\31TelescopeResultsDiffDelete\1\0\0\bred\26TelescopePromptPrefix\1\0\0\22TelescopeMatching\1\0\0\20TelescopeNormal\1\0\0\28TelescopeMultiSelection\1\0\0\23TelescopeSelection\1\0\0\27TelescopePreviewBorder\1\0\0\27TelescopeResultsBorder\1\0\0\26TelescopePromptBorder\1\0\0\21StatusLineTermNC\1\0\0\19StatusLineTerm\1\0\0\17StatusLineNC\1\0\0\15StatusLine\1\0\1\tbold\2\25IlluminatedWordWrite\1\0\0\24IlluminatedWordRead\1\0\0\24IlluminatedWordText\1\0\0\23illuminatedCurWord\1\0\0\20illuminatedWord\1\0\0\15PmenuThumb\1\0\0\14PmenuSbar\1\0\0\rPmenuSel\1\0\0\nPmenu\tmenu\1\0\0\15MatchParen\1\0\1\14underline\2\vLineNr\1\0\0\14IncSearch\1\0\0\vSearch\19bright_magenta\1\0\0\15FoldColumn\vFolded\1\0\0\17WinSeparator\1\0\0\14VertSplit\1\0\0\tpink\rErrorMsg\1\0\0\14Directory\1\0\0\vpurple\16ColorColumn\1\0\0\15CursorLine\1\0\0\14selection\17CursorColumn\18bright_yellow\1\0\0\fConceal\1\0\0\15SignColumn\1\0\0\17CursorLineNr\1\0\1\tbold\2\nblack\vCursor\1\0\1\freverse\2\rDiffText\1\0\0\15DiffChange\1\0\0\fcomment\15DiffDelete\1\0\0\15bright_red\fDiffAdd\abg\1\0\0\17bright_green\fNonText\1\0\0\nwhite\16FloatBorder\1\0\0\afg\1\0\0\18orange_yellow�\4\1\0\4\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0023\3\6\0=\3\a\2B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0\24colorscheme dracula\bcmd\bvim\14overrides\0\vcolors\1\0\4\19italic_comment\2\21lualine_bg_color\f#44475a\19transparent_bg\2\23show_end_of_buffer\2\1\0\25\fcomment\f#6272A4\afg\f#F8F8F2\vyellow\f#F1FA8C\17bright_green\f#69FF94\tcyan\f#8BE9FD\19bright_magenta\f#FF79c6\16bright_cyan\f#A4FFFF\tmenu\f#21222C\tpink\f#FF37BA\nwhite\f#ABB2BF\18orange_yellow\f#ffeb20\vvisual\f#3E4452\vorange\f#FFB86C\nblack\f#191A21\14selection\f#44475A\fnontext\f#3B4048\14gutter_fg\f#4B5263\17bright_white\f#FFFFFF\abg\tnone\ngreen\f#50fa7b\bred\f#FF5555\vpurple\f#BD93F9\16bright_blue\f#D6ACFF\18bright_yellow\f#FFFFA5\15bright_red\f#FF6E6E\nsetup\fdracula\frequire\0", "config", "dracula")
time([[Config for dracula]], false)
-- Config for: conform.nvim
time([[Config for conform.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fconform\frequire\0", "config", "conform.nvim")
time([[Config for conform.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\nT\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\17open_mapping\f<C-S-T>\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'alpha-nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
