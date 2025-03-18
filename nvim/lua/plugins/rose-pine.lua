return {
  "rose-pine/neovim",
  config = function()
    require("rose-pine").setup({
      dark_variant = "moon",
      groups = {
        border = "gold",
        panel = "none",
        comment = "muted",
        link = "iris",
        punctuation = "subtle",
        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",
      },

      styles = {
        bold = true,
        italic = false,
        transparency = true,
      },

      highlight_groups = {
        TelescopeBorder = { fg = "highlight_high", bg = "none" },
        TelescopeNormal = { bg = "none" },
        TelescopePromptNormal = { bg = "none" },
        TelescopeResultsNormal = { fg = "subtle", bg = "none" },
        TelescopeSelection = { fg = "text", bg = "base" },
        TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
      },
    })

    vim.cmd([[colorscheme rose-pine]])

    local highlights = require("rose-pine.plugins.bufferline")
    require("bufferline").setup({
      highlights = highlights,
      options = {
        close_command = "bp|sp|bn|bd! %d",
        right_mouse_command = "bp|sp|bn|bd! %d",
        left_mouse_command = "buffer %d",
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        show_close_icon = false,
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 18,
        show_tab_indicators = true,
        indicator = {
          style = "underline",
        },
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "thin",
        always_show_bufferline = true,
        diagnostics = false,
        themable = true,
      },
    })

    -- Key mappings for Bufferline
    vim.keymap.set("n", "<leader>tn", ":BufferLineCycleNext<CR>", { desc = "Go to next tab" })
    vim.keymap.set("n", "<leader>tp", ":BufferLineCyclePrev<CR>", { desc = "Go to previous tab" })
    vim.keymap.set("n", "<leader>tc", ":BufferLinePickClose<CR>", { desc = "Pick close tab" })
    vim.keymap.set("n", "<leader>tco", ":BufferLineCloseOthers<CR>", { desc = "Close all other tabs" })
    vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open a new tab" })
    vim.keymap.set("n", "<leader>ts", ":BufferLineSortByDirectory<CR>", { desc = "Sort by directory" })

    -- Close specific tabs
    for i = 1, 10 do
      vim.keymap.set("n", "<leader>t" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Go To Bufferline " .. i })
    end
  end
}
