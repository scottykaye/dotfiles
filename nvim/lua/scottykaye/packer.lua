-- This file can be loaded by calling `lua require('plugins')` from your init.vim Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]



return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')
  use({
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',
    tag = '0.1.4',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  })
  use('NvChad/nvim-colorizer.lua')
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  use({
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { { "nvim-lua/plenary.nvim" } }
  })
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('tpope/vim-surround')
  use("lukas-reineke/indent-blankline.nvim")
  use('stevearc/dressing.nvim')
  use({ 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig' })
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-nvim-lsp')
  use({
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  })
  use('nvim-treesitter/nvim-treesitter-context')
  use('nvim-tree/nvim-web-devicons')
  use('MunifTanjim/prettier.nvim')
  use("folke/zen-mode.nvim")
  --  use("github/copilot.vim")
  use("eandrju/cellular-automaton.nvim")
  use("laytan/cloak.nvim")
  use("dnlhc/glance.nvim")
  use('iamcco/markdown-preview.nvim')
  use('rcarriga/nvim-notify')
  use('onsails/lspkind-nvim')
  use('stevearc/conform.nvim')
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')
  use('rafamadriz/friendly-snippets')
  use({ 'echasnovski/mini.nvim', version = false })
  use('folke/which-key.nvim')
  use({
    "NeogitOrg/neogit",
    requires = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    }
  })
  use('lewis6991/gitsigns.nvim')
  use({
    "akinsho/toggleterm.nvim",
    tag = '*',
  })
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  })
  use('windwp/nvim-autopairs')
  use('ggandor/leap.nvim')
  --  use({
  --    'zbirenbaum/copilot.lua',
  --    cmd = "Copilot",
  --    event = "InsertEnter",
  --    config = function()
  --      require("copilot").setup({
  --        suggestion = { enabled = false },
  --        panel = { enabled = false },
  --      })
  --    end,
  --  })
  --  use({
  --    'zbirenbaum/copilot-cmp',
  --    config = function()
  --      require("copilot_cmp").setup()
  --    end,
  --  })
  use({
    'akinsho/bufferline.nvim',
    event = 'ColorScheme',

  })
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
  })
  use({
    "samjwill/nvim-unception",
    dependencies = {
      { "numToStr/FTerm.nvim" },
    },
    init = function()
      vim.g.unception_open_buffer_in_new_tab = true
    end,
    config = function()
      vim.api.nvim_create_autocmd(
        "User",
        {
          pattern = "UnceptionEditRequestReceived",
          callback = function()
            require('FTerm').toggle()
          end
        }
      )
    end
  })
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    event = 'VimEnter',
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      math.randomseed(os.time())

      local function pick_color()
        local colors = { "String", "Identifier", "Keyword", "Number" }
        return colors[math.random(#colors)]
      end

      local function footer()
        local total_plugins = #vim.tbl_keys(packer_plugins)
        local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
        local version = vim.version()
        local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

        return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
      end

      local logo = {

        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ", }

      dashboard.section.header.val = logo
      dashboard.section.header.opts.hl = pick_color()

      dashboard.section.buttons.val = {
        dashboard.button("<leader>fb", "  File Browser"),
        dashboard.button("<leader>pf", "  Find File"),
        dashboard.button("<C-e>", "  Recent Project Files"),
        dashboard.button("<leader>ps", "  Project Search"),
        dashboard.button("<leader>vpp", "  Update plugins"),
        dashboard.button("q", "  Quit", ":qa<cr>")
      }

      dashboard.section.footer.val = footer()
      dashboard.section.footer.opts.hl = "Constant"

      alpha.setup(dashboard.opts)

      vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
    end
  })

  use({
    'monkoose/neocodeium',
    event = 'InsertEnter',
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup()

      -- Define keymaps for Neocodeium functions
      vim.keymap.set("i", "<C-f>", function()
        require("neocodeium").accept()
      end)
      vim.keymap.set("i", "<C-w>", function()
        require("neocodeium").accept_word()
      end)
      vim.keymap.set("i", "<C-a>", function()
        require("neocodeium").accept_line()
      end)
      vim.keymap.set("i", "<C-e>", function()
        require("neocodeium").cycle_or_complete()
      end)
      vim.keymap.set("i", "<C-r>", function()
        require("neocodeium").cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<C-c>", function()
        require("neocodeium").clear()
      end)
    end
  })
  --  use({
  --    'Mofiqul/dracula.nvim',
  --    as = "dracula",
  --  })

  -- Unused themes
  --   use({
  --     'NLKNguyen/papercolor-theme',
  --     config = function()
  --       vim.cmd([[
  --         let g:PaperColor_Theme_Options = {
  --           \   'theme': {
  --           \     'default': {
  --           \       'transparent_background': 1,
  --           \       'override' : {
  --           \         'color00' : ['#080808', '232'],
  --           \         'linenumber_bg' : ['#080808', '232']
  --           \       }
  --           \     }
  --           \   }
  --           \ }
  --       ]])
  --       vim.cmd([[colorscheme PaperColor]])
  --     end
  --   })

  -- use { "catppuccin/nvim", as = "catppuccin", config = function()
  -- vim.cmd([[colorscheme catppuccin]])
  -- end
  -- }
  --  Haven't been using this. This produces a new vim tree that stays with you
  --use {
  --  'nvim-tree/nvim-tree.lua',
  --  requires = {
  --    'nvim-tree/nvim-web-devicons', -- optional
  --  },
  --  config = function()
  --    require("nvim-tree").setup {}
  --  end
  --}
  -- use { "ellisonleao/gruvbox.nvim" }
  --   require("gruvbox").setup({
  --   terminal_colors = true, -- add neovim terminal colors
  --   undercurl = true,
  --   underline = true,
  --   bold = true,
  --   italic = {
  --     strings = true,
  --     emphasis = true,
  --     comments = true,
  --     operators = false,
  --     folds = true,
  --   },
  --   strikethrough = true,
  --   invert_selection = false,
  --   invert_signs = false,
  --   invert_tabline = false,
  --   invert_intend_guides = false,
  --   inverse = true, -- invert background for search, diffs, statuslines and errors
  --   contrast = "", -- can be "hard", "soft" or empty string
  --   palette_overrides = {},
  --   overrides = {},
  --   dim_inactive = false,
  --   transparent_mode = false,
  --     palette_overrides = {
  --         bright_green = "#66ff00",
  --     }
  -- })
  -- vim.cmd("colorscheme gruvbox")
end)
