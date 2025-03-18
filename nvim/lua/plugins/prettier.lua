return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local prettier = require("prettier")

    prettier.setup({
      bin = 'prettier',
      filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
      },
    })
  end
}
