require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "black" },
    go = { "goimports", "gofumpt", "goimports-reviser" },

    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettier", "eslint_d", "biome", "biome-check" } },
    css = { { "prettier", "biome", "biome-check" } },
    scss = { { "prettier", "biome", "biome-check" } },
    html = { { "prettier", "biome", "biome-check" } },
    javascriptreact = { { "prettier", "eslint_d", "biome", "biome-check" } },
    typescript = { { "prettier", "eslint_d", "biome", "biome-check" } },
    typescriptreact = { { "prettier", "eslint_d", "biome", "biome-check" } },
    markdown = { { "prettier", "biome", "biome-check" } },
    mdx = { { "prettier", "biome", "biome-check" } },
    json = { { "prettier", "biome", "biome-check" } },
    jsonc = { { "prettier", "biome", "biome-check" } },
    bash = { "shfmt" },
    yaml = { { "prettier" } },
    graphql = { { "prettier" } },
    handlebars = { { "prettier" } },
    zsh = { 'beautysh' },
    sh = { 'beautysh' },
    astro = { "prettier" }
  },
  python = function(bufnr)
    if require("conform").get_formatter_info("biome", bufnr).available then
      return { "biome" }
    elseif require("conform").get_formatter_info("biome-check", bufnr).available then
      return { "biome-check" }
    else
      return { "prettier", "eslint" }
    end
  end,
  ["*"] = { "codespell" },
  ["_"] = { "trim_whitespace" },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  log_level = vim.log.levels.ERROR,
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
