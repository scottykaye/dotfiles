require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "black" },
    go = { "gofmt", "goimports", "gofumpt", "goimports-reviser" },
    -- Use a sub-list to run only the first available formatter
    css = { "biome-check", "prettier" },
    scss = { "biome-check", "prettier" },
    html = { "biome-check", "prettier" },
    javascript = { "biome-check", "prettier" },
    javascriptreact = { "biome-check", "prettier" },
    typescript = { "biome-check", "prettier" },
    typescriptreact = { "biome-check", "prettier" },
    markdown = { "biome-check", "prettier" },
    mdx = { "biome-check", "prettier" },
    json = { "biome-check", "prettier" },
    jsonc = { "biome-check", "prettier" },
    bash = { "shfmt" },
    yaml = { { "prettier" } },
    graphql = { { "prettier" } },
    handlebars = { { "prettier" } },
    zsh = { "beautysh" },
    sh = { "beautysh" },
    astro = { "prettier" }
  },
  ["*"] = { "codespell" },
  ["_"] = { "trim_whitespace" },

})


local get_closest_formatter = require("conform").get_closest_formatter

vim.api.nvim_create_user_command("Format", function()
  --- NOTE: table<formatter, table<config_file>>
  local formatters = get_closest_formatter({
    ["biome-check"] = { "biome.json" },
    gofmt = { "goimports", "go.mod" },
    goimports = { "go.mod" },
    prettier = { ".prettierrc", "prettier.config.js" },
    stylua = { "stylua.toml" },
  })

  if not formatters then
    print("formatter not found, using lsp")
    require("conform").format({ async = true, lsp_fallback = true })
  else
    print("formatted with " .. formatters[1])
    require("conform").format({ async = true, formatters, lsp_fallback = false })
  end
end, {})

vim.api.nvim_create_user_command("FormatWithBiome", function()
  require("conform").format({
    async = true,
    formatters = { "biome-check" },
    lsp_fallback = false,
  })
end, {})

vim.api.nvim_create_user_command("FormatWithPrettier", function()
  require("conform").format({
    async = true,
    formatters = { "prettier" },
    lsp_fallback = false,
  })
end, {})




require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  log_level = vim.log.levels.ERROR,
})



vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

vim.api.nvim_set_keymap('n', '<leader>f', ':Format<CR>', { silent = true })
