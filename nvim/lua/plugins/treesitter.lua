return {
  "nvim-treesitter/nvim-treesitter", -- Plugin declaration
  run = ":TSUpdate", -- Ensures the parsers are installed on the first run
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = {
        "javascript", "html", "typescript", "markdown", "markdown_inline", "go", "rust", "c", "lua",
        "vim", "vimdoc", "query"
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      ts_context_commentstring = {
        enable = true,
        enable_autcmd = false,
        config = {
          javascript = {
            __default = '// %s',
            jsx_element = '{/* %s */}',
            jsx_fragment = '{/* %s */}',
            jsx_attribute = '// %s',
            comment = '// %s',
          },
          typescript = { __default = '// %s', __multiline = '/* %s */' },
        },
      },
    }

    -- Add custom filetype for mdx
    vim.filetype.add({
      extension = {
        mdx = 'mdx'
      }
    })

    -- Setup for additional Treesitter context
    require('treesitter-context').setup({})

    -- Setup for context-specific comment strings
    require('ts_context_commentstring').setup {
      enable_autocmd = false,
    }

    -- Setup for Comment.nvim with treesitter context integration
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }

    -- Optional: Fix any filetype parser issues
    -- local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
    -- ft_to_parser.mdx = "markdown"
  end,
}
