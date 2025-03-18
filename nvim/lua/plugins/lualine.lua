return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "rose-pine/neovim" },
  config = function()
    local rose_pine = require("lualine.themes.rose-pine")

    rose_pine.normal.c = { fg = rose_pine.normal.a.fg, bg = "#eb6f92", gui = "bold" }
    rose_pine.insert.c = { fg = rose_pine.normal.a.fg, bg = "#9ccfd8", gui = "bold" }
    rose_pine.visual.c = { fg = rose_pine.normal.a.fg, bg = "#c4a7e7", gui = "bold" }

    local function window()
      return vim.api.nvim_win_get_number(0)
    end

    require("lualine").setup({
      sections = {
        lualine_a = { window },
        lualine_c = { { 'filename', path = 2 } }
      },
      inactive_sections = {
        lualine_c = { { 'filename', path = 2 } }
      },

      options = {
        theme = rose_pine, -- Use the modified Rose Pine theme
      },
    })
  end
}
