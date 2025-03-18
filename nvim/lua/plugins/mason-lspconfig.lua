return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("mason-lspconfig").setup({
      ensured_installed = { "lua_ls", "solargraph", "ts_ls", "biome", "eslint", "tailwindcss", "phpactor", "php-cs-fixer" },
    })
  end
}
