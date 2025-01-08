return {
  -- Telescope and dependencies
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    tag = "0.1.4",
    config = function()
      require("scottykaye.config.plugins.telescope")
    end,
  },
  "nvim-telescope/telescope-fzy-native.nvim",
  {
    "nvim-telescope/telescope-file-browser.nvim",
    config = function()
      require("scottykaye.config.plugins.telescope-file-browser")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("scottykaye.config.plugins.harpoon")
    end,
  },

  -- Treesitter and related plugins
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("scottykaye.config.plugins.treesitter")
    end,
  },
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-context",

  -- Colorschemes and UI enhancements
  {
    "rose-pine/neovim",
    config = function()
      require("scottykaye.config.plugins.rose-pine")
    end,
  },
  { "nvim-tree/nvim-web-devicons", opt = true },
  "lukas-reineke/indent-blankline.nvim",
  "stevearc/dressing.nvim",
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  "rcarriga/nvim-notify",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("scottykaye.config.plugins.lualine")
    end,
  },

  -- Git and version control
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("scottykaye.config.plugins.gitsigns")
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("scottykaye.config.plugins.neogit")
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      require("scottykaye.config.plugins.fugitive")
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("scottykaye.config.plugins.mason")
    end,
  },
  -- LSP and completion
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("scottykaye.config.plugins.mason-lspconfig")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("scottykaye.config.plugins.lsp")
    end,
  },
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "onsails/lspkind-nvim",
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
    config = function()
      require("scottykaye.config.plugins.completions")
    end,
  },

  -- Utilities
  {
    "mbbill/undotree",
    config = function()
      require("scottykaye.config.plugins.undotree")
    end,
  },
  "tpope/vim-surround",
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-completion",
  "kristijanhusak/vim-dadbod-ui",
  {
    "stevearc/conform.nvim",
    config = function()
      require("scottykaye.config.plugins.conform")
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("scottykaye.config.plugins.nvim-autopairs")
    end,
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("scottykaye.config.plugins.leap")
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("scottykaye.config.plugins.which-key")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("scottykaye.config.plugins.termtoggle")
    end,
  },
  {
    "MunifTanjim/prettier.nvim",
    config = function()
      require("scottykaye.config.plugins.prettier")
    end,
  },
  "folke/zen-mode.nvim",
  "eandrju/cellular-automaton.nvim",
  "laytan/cloak.nvim",
  {
    "dnlhc/glance.nvim",
    config = function()
      require("scottykaye.config.plugins.glance")
    end,
  },
  "iamcco/markdown-preview.nvim",

  -- Custom plugins
  {
    "samjwill/nvim-unception",
    dependencies = { "numToStr/FTerm.nvim" },
    init = function()
      vim.g.unception_open_buffer_in_new_tab = true
    end,
    config = function()
      require("scottykaye.config.plugins.unception")
    end,
  },

  -- Alpha dashboard
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("scottykaye.config.plugins.alpha")
    end,
  },

  -- Experimental
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      require("scottykaye.config.plugins.neocodium")
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("scottykaye.config.plugins.colorizer")
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
      provider = "copilot",
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",      -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
