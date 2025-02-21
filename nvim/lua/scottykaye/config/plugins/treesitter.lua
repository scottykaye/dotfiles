require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "javascript", "html", "typescript", "markdown", "markdown_inline",
    "go", "rust", "c", "lua", "vim", "vimdoc", "query"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

vim.filetype.add({
  extension = {
    mdx = 'mdx'
  }
})

require('treesitter-context').setup({})

require('ts_context_commentstring').setup {
  enable_autocmd = false,
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
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
}
