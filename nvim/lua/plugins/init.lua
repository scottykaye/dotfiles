return {

  -- Folke Plugins
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          {
            pane = 2,
            section = "terminal",
            cmd = "colorscript -e square",
            height = 5,
            padding = 1,
          },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
      indent = {
        enabled = true,

        priority = 1,
        char = "│",
        only_scope = false,   -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window


      },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      explorer = {
        enabled = true,
        hijack_netrw = true,
      },

      picker = {
        enabled = true,
        debug = { scores = false, leaks = false, explorer = true, files = true },
        sources = {
          files_with_symbols = {
            multi = { "files", "lsp_symbols" },
            filter = {
              ---@param p snacks.Picker
              ---@param filter snacks.picker.Filter
              transform = function(p, filter)
                local symbol_pattern = filter.pattern:match("^.-@(.*)$")
                -- store the current file buffer
                if filter.source_id ~= 2 then
                  local item = p:current()
                  if item and item.file then
                    filter.meta.buf = vim.fn.bufadd(item.file)
                  end
                end

                if symbol_pattern and filter.meta.buf then
                  filter.pattern = symbol_pattern
                  filter.current_buf = filter.meta.buf
                  filter.source_id = 2
                else
                  filter.source_id = 1
                end
              end,
            },
          },
          explorer = {
            focus = "input",
            auto_close = true,

            layout = {
              cycle = true,
              preset = function()
                return vim.o.columns >= 120 and "default" or "vertical"
              end,
              preview = "preview",
            },

          },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader>sm", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
      { "<leader>b",  function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>ps", function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>:",  function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>n",  function() Snacks.picker.notifications() end,                           desc = "Notification History" },
      { "<leader>fb", function() Snacks.picker.explorer() end,                                desc = "File Explorer" },
      -- find
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>pf", function() Snacks.picker.files() end,                                   desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
      { "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
      { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },
      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
      { "<leader>gl", function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
      { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
      { "<leader>gd", function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end,                               desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end,                          desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
      { "<leader>sb", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sc", function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end,                                desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end,                                    desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end,                              desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end,                                   desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end,                                 desc = "Location List" },
      { "<leader>ma", function() Snacks.picker.marks() end,                                   desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end,                                     desc = "Man Pages" },
      { "<leader>sp", function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
      { "<leader>sR", function() Snacks.picker.resume() end,                                  desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end,                                    desc = "Undo History" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
      -- LSP
      { "gd",         function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
      { "gD",         function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
      { "gr",         function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
      { "gI",         function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
      { "gy",         function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
      -- Other
      { "<leader>z",  function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
      { "<leader>.",  function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
      { "<leader>gg", function() Snacks.lazygit() end,                                        desc = "Lazygit" },
      { "<leader>un", function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
      { "<c-/>",      function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
      { "<c-_>",      function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      }
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
            "<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
          -- Toggle the profiler
          Snacks.toggle.profiler():map("<leader>pp")
          -- Toggle the profiler highlights
          Snacks.toggle.profiler_highlights():map("<leader>ph")
        end,
      })
    end,
  },

  {
    "folke/which-key.nvim",
    config = function()
      require("plugins.which-key")
    end,
  },


  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        -- Negatives: Not repeatable with ; and ,
        -- But do I REALLY need ; ?. It works with macros so, meh.
        char = {
          enabled = false,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash: Jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash: Select Treesitter",
      },

      -- o (Operator-pending mode): d, y, or c
      -- Example: y { r <jump> } i w
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Flash: Remote",
      },

      -- x (Visual mode - exclusive selection)
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash: Remote Treesitter",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },



  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.harpoon")
    end,
  },

  --   -- Treesitter and related plugins
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-context",

  --   -- Comments
  'numToStr/Comment.nvim',
  'JoosepAlviste/nvim-ts-context-commentstring',

  -- Colorschemes and UI enhancements
  {
    "rose-pine/neovim",

    config = function()
      require("plugins.rose-pine")
    end,
  },
  { "nvim-tree/nvim-web-devicons", opt = true },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("plugins.lualine")
    end,
  },


  "rcarriga/nvim-notify",
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("plugins.rainbow-delimiters")
    end,
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
      refresh_interval = 400,
      bookmark_0 = {
        sign = "⚑",
        annotate = false,
      },
    },
  },



  {
    'petertriho/nvim-scrollbar',
    config = function()
      require("plugins.scrollbar")
    end
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.gitsigns")
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("plugins.neogit")
    end,
  },


  -- LSP and completion
  {
    "williamboman/mason.nvim",
    config = function()
      require("plugins.mason")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("plugins.mason-lspconfig")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end,
  },
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "onsails/lspkind-nvim",
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
    config = function()
      require("plugins.completions")
    end,
  },
  "kshenoy/vim-signature",
  -- Utilities
  {
    "mbbill/undotree",
    config = function()
      require("plugins.undotree")
    end,
  },

  --   Database
  "tpope/vim-surround",
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-completion",
  "kristijanhusak/vim-dadbod-ui",

  {
    "stevearc/conform.nvim",
    config = function()
      require("plugins.conform")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.nvim-autopairs")
    end,
  },

  {
    "MunifTanjim/prettier.nvim",
    config = function()
      require("plugins.prettier")
    end,
  },
  --
  --   allows me to do make it rain so unnecessary so cool
  "eandrju/cellular-automaton.nvim",
  "iamcco/markdown-preview.nvim",

  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      position = "top-right",
      timeout = 1,
      maxkeys = 5,
    },
  },
  --
  --   -- Custom plugins
  {
    "samjwill/nvim-unception",
    dependencies = { "numToStr/FTerm.nvim" },
    init = function()
      vim.g.unception_open_buffer_in_new_tab = true
    end,
    config = function()
      require("plugins.unception")
    end,
  },
  --

  --
  ---- -- Experimental
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      require("plugins.neocodeium")
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugins.colorizer")
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
  }



  --   {
  --   "Mofiqul/dracula.nvim",
  --   config = function()
  --     require("plugins.dracula")
  --   end,
  -- },

  --   {
  --     "ggandor/leap.nvim",
  --     config = function()
  --       require("plugins.leap")
  --     end,
  --   },


  --   {
  --     "tpope/vim-fugitive",
  --     config = function()
  --       require("plugins.fugitive")
  --     end,
  --   },
  --

  --   "laytan/cloak.nvim",
  --   {
  --     "dnlhc/glance.nvim",
  --     config = function()
  --       require("plugins.glance")
  --     end,
  --   },

  --
  --   -- Telescope and dependencies
  --   {
  --     "nvim-telescope/telescope.nvim",
  --     dependencies = { "nvim-lua/plenary.nvim" },
  --     tag = "0.1.4",
  --     config = function()
  --       require("plugins.telescope")
  --     end,
  --   },
  --   "nvim-telescope/telescope-fzy-native.nvim",
  --   {
  --     "nvim-telescope/telescope-file-browser.nvim",
  --     config = function()
  --       require("plugins.telescope-file-browser")
  --     end,
  --   },



  --   {
  --     "lukas-reineke/indent-blankline.nvim",
  --     main = "ibl",
  --     opts = {},
  --     config = function()
  --       local highlight = {
  --         "RainbowRed",
  --         "RainbowYellow",
  --         "RainbowBlue",
  --         "RainbowOrange",
  --         "RainbowGreen",
  --         "RainbowViolet",
  --         "RainbowCyan",
  --       }
  --       local hooks = require "ibl.hooks"
  --       -- create the highlight groups in the highlight setup hook, so they are reset
  --       -- every time the colorscheme changes
  --       hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  --         vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  --         vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  --         vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  --         vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  --         vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  --         vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  --         vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  --       end)
  --
  --       vim.g.rainbow_delimiters = { highlight = highlight }
  --       require("ibl").setup { scope = { highlight = highlight } }
  --
  --       hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  --     end,
  --   },



}
