return {
	-- Telescope and dependencies
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		tag = "0.1.4",
		config = function()
			require("scottykaye.config.plugins.telescope")
		end
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
	"NvChad/nvim-colorizer.lua",
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
{		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,

},
	-- LSP and completion
  {		"williamboman/mason-lspconfig.nvim",
  	config = function()
			require("mason-lspconfig").setup({
				ensured_installed = { "lua_ls", "solargraph", "ts_ls", "biome", "eslint", "tailwindcss" },
			})
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
			vim.api.nvim_create_autocmd("User", {
				pattern = "UnceptionEditRequestReceived",
				callback = function()
					require("FTerm").toggle()
				end,
			})
		end,
	},

	-- Alpha dashboard
	{
		"goolord/alpha-nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			math.randomseed(os.time())
			local function pick_color()
				local colors = { "String", "Identifier", "Keyword", "Number" }
				return colors[math.random(#colors)]
			end

			local logo = {
				"                                                     ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
				"                                                     ",
			}

			dashboard.section.header.val = logo
			dashboard.section.header.opts.hl = pick_color()

			alpha.setup(dashboard.opts)
		end,
	},

	-- Experimental
	"monkoose/neocodeium",

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("scottykaye.config.plugins.colorizer")
		end,
	},
}
