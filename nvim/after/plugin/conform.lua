local getFormatOrder = function(bufnr)
  if require("conform").get_formatter_info("biome-check", bufnr).available then
    return { "biome-check" }
  else
    return { "prettier", "eslint" }
  end
end

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "black" },
    go = { "gofmt", "goimports", "gofumpt", "goimports-reviser" },
    -- Use a sub-list to run only the first available formatter
    css = getFormatOrder,
    scss = getFormatOrder,
    html = getFormatOrder,
    javascript = getFormatOrder,
    javascriptreact = getFormatOrder,
    typescript = getFormatOrder,
    typescriptreact = getFormatOrder,
    markdown = getFormatOrder,
    mdx = getFormatOrder,
    json = getFormatOrder,
    jsonc = getFormatOrder,
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
