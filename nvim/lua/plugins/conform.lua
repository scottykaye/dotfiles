---@param originalTable table<string, string[]>
---@param keysToInclude string[]
local filter_table = function(originalTable, keysToInclude)
  local resultTable = {}

  for _, key in ipairs(keysToInclude) do
    local value = originalTable[key]
    if value then
      resultTable[key] = value
    end
  end

  return resultTable
end

---@param path_one string
---@param current_buffer string
local get_distance_to = function(path_one, current_buffer)
  if path_one == nil then
    return math.huge
  end

  local common_prefix = ""
  local current_remaining = ""
  local other_remaining = ""

  for i = 1, math.min(#current_buffer, #path_one) do
    if current_buffer:sub(i, i) == path_one:sub(i, i) then
      common_prefix = common_prefix .. current_buffer:sub(i, i)
    else
      current_remaining = current_buffer:sub(i)
      other_remaining = path_one:sub(i)
      break
    end
  end

  -- Calculate the distance by counting directory separators
  local distance = 0

  for _ in current_remaining:gmatch("/") do
    distance = distance + 1
  end

  for _ in other_remaining:gmatch("/") do
    distance = distance + 1
  end

  return distance
end

---@param glob string The glob pattern to convert (e.g., "**/*.js")
---@return string The equivalent Lua pattern
local glob_to_lua_pattern = function(glob)
  local pattern = glob
  -- Escape Lua magic characters (except * and ?)
  pattern = pattern:gsub("([%.%+%-%^%$%(%)%[%]%%])", "%%%1")
  -- Use placeholder for ** to avoid double-conversion
  pattern = pattern:gsub("%*%*", "\001DOUBLESTAR\001")
  -- Convert single * to match anything except /
  pattern = pattern:gsub("%*", "[^/]*")
  -- Convert ** placeholder back to match anything including /
  pattern = pattern:gsub("\001DOUBLESTAR\001", ".*")
  -- Convert ? to match single character except /
  pattern = pattern:gsub("%?", "[^/]")
  return "^" .. pattern .. "$"
end

-- Cache for parsed biome configs
---@type table<string, { includes: string[]|nil }>
local biome_config_cache = {}

---@param biome_json_path string Absolute path to biome.json
---@return { includes: string[]|nil }|nil
local parse_biome_config = function(biome_json_path)
  -- Check cache first
  if biome_config_cache[biome_json_path] then
    return biome_config_cache[biome_json_path]
  end

  -- Read and parse the file
  local file = io.open(biome_json_path, "r")
  if not file then
    return nil
  end

  local content = file:read("*a")
  file:close()

  local ok, data = pcall(vim.json.decode, content)
  if not ok or not data then
    return nil
  end

  -- Extract includes array
  local result = {
    includes = data.files and data.files.includes or nil,
  }

  -- Cache the result
  biome_config_cache[biome_json_path] = result
  return result
end

---@param biome_json_path string Absolute path to biome.json
---@param file_path string Absolute path to the file being formatted
---@return boolean True if biome will format this file
local biome_supports_file = function(biome_json_path, file_path)
  local config = parse_biome_config(biome_json_path)

  -- If no config or no includes specified, assume all files are supported
  if not config or not config.includes then
    return true
  end

  -- Get file path relative to biome.json directory
  local biome_dir = vim.fn.fnamemodify(biome_json_path, ":h")
  local relative_path = file_path
  if file_path:sub(1, #biome_dir) == biome_dir then
    relative_path = file_path:sub(#biome_dir + 2) -- +2 to skip the /
  end

  -- Check negative patterns (exclusions) first
  for _, pattern in ipairs(config.includes) do
    if pattern:sub(1, 1) == "!" then
      local exclude_pattern = pattern:sub(2)
      if relative_path:match(glob_to_lua_pattern(exclude_pattern)) then
        return false
      end
    end
  end

  -- Check if file matches any positive include pattern
  for _, pattern in ipairs(config.includes) do
    if pattern:sub(1, 1) ~= "!" then
      if relative_path:match(glob_to_lua_pattern(pattern)) then
        return true
      end
    end
  end

  -- No pattern matched
  return false
end

---@param _formatters table<string, string[]>
---@return string[] | nil
local get_closest_formatter = function(_formatters)
  ---@type string
  local current_buffer_path = vim.api.nvim_buf_get_name(0)

  local available_formatters = require("conform").list_formatters(0)
  local keys_to_include = {}
  for _, value in ipairs(available_formatters) do
    table.insert(keys_to_include, value.name)
  end
  ---@type table<string, string[]>
  _formatters = filter_table(_formatters, keys_to_include)

  ---@type table<string, { distance: number, config_path: string }>
  local formatter_info = {}

  for formatter_name, formatter_configs in pairs(_formatters) do
    local formatter_config_path = nil

    for _, v in ipairs(formatter_configs) do
      local found = vim.fs.find(v, {
        upward = true,
        path = vim.fn.fnamemodify(current_buffer_path, ":h"),
      })

      if found[1] ~= nil then
        formatter_config_path = found[1]
        break
      end
    end

    if formatter_config_path then
      formatter_info[formatter_name] = {
        distance = get_distance_to(formatter_config_path, current_buffer_path),
        config_path = formatter_config_path,
      }
    end
  end

  -- Sort formatters by distance (closest first)
  local sorted_formatters = {}
  for name, info in pairs(formatter_info) do
    table.insert(sorted_formatters, { name = name, distance = info.distance, config_path = info.config_path })
  end
  table.sort(sorted_formatters, function(a, b)
    return a.distance < b.distance
  end)

  -- Find the first formatter that supports the current file
  for _, formatter in ipairs(sorted_formatters) do
    local should_use = true

    -- Validate biome-check supports the file type
    if formatter.name == "biome-check" then
      if not biome_supports_file(formatter.config_path, current_buffer_path) then
        -- Skip biome-check, try next formatter
        should_use = false
      end
    end

    if should_use then
      return { formatter.name }
    end
  end

  return nil
end

require("conform").setup({
  formatters_by_ft = {
    -- lspconfig handles this
    lua = {},
    python = { "black" },
    go = { "gofmt", "goimports", "gofumpt", "goimports-reviser" },
    java = { "google-java-format" },
    kotlin = { "ktlint" },
    css = { "biome-check", "prettier" },
    scss = { "biome-check", "prettier" },
    html = { "biome-check", "prettier" },
    javascript = { "biome-check", "prettier" },
    javascriptreact = { "biome-check", "prettier" },
    typescript = { "biome-check", "prettier" },
    typescriptreact = { "biome-check", "prettier" },
    markdown = { "markdownlint", "prettier" },
    mdx = { "biome-check", "prettier" },
    json = { "biome-check", "prettier" },
    jsonc = { "biome-check", "prettier" },
    bash = { "shfmt" },
    yaml = { "prettier" },
    graphql = { "biome-check", "prettier" },
    handlebars = { "prettier" },
    zsh = { "beautysh" },
    sh = { "beautysh" },
    astro = { "prettier" },
    php = { "php_cs_fixer" },
  },
  ["*"] = { "codespell" },
  ["_"] = { "trim_whitespace" },
})

vim.api.nvim_create_user_command("Format", function()
  local formatters = get_closest_formatter({
    ["biome-check"] = { "biome.json" },
    markdownlint = { ".markdownlint.json", ".markdownlintrc", ".markdownlint.yaml", ".markdownlint.yml" },
    gofmt = { "goimports", "go.mod" },
    goimports = { "go.mod" },
    ["google-java-format"] = { "BUILD.bazel", "WORKSPACE.bazel", "build.gradle", "pom.xml" },
    ktlint = { ".editorconfig" },
    prettier = { ".prettierrc", "prettier.config.js" },
  })

  if not formatters then
    -- For YAML files, skip formatting if no prettier config found
    -- (treehouse uses editorconfig for YAML, frontend repos have .prettierrc)
    local filetype = vim.bo.filetype
    if filetype == "yaml" then
      print("No formatter config found for YAML - using editorconfig only")
      return
    end

    print("formatter not found, using lsp")
    require("conform").format({ async = true, lsp_fallback = true })
  else
    print("formatted with " .. formatters[1])
    require("conform").format({ async = true, formatters = formatters, lsp_fallback = false })
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

vim.api.nvim_set_keymap("n", "<leader>F", ":Format<CR>", { silent = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
  callback = function()
    -- Use get_closest_formatter to determine the formatter
    local formatters = get_closest_formatter({
      ["biome-check"] = { "biome.json" },
      markdownlint = { ".markdownlint.json", ".markdownlintrc", ".markdownlint.yaml" },
      gofmt = { "goimports", "go.mod" },
      goimports = { "go.mod" },
      ["google-java-format"] = { "BUILD.bazel", "WORKSPACE.bazel", "build.gradle", "pom.xml" },
      ktlint = { ".editorconfig" },
      prettier = { ".prettierrc", "prettier.config.js" },
    })

    if not formatters then
      -- Skip formatting if no config found for these types:
      -- YAML: treehouse uses editorconfig, frontend repos have .prettierrc
      -- JSON/JSONC: pineapple excludes JSON from biome and has no .prettierrc,
      --             so lsp_fallback would invoke biome LSP which ignores files.includes
      local filetype = vim.bo.filetype
      if filetype == "yaml" or filetype == "json" or filetype == "jsonc" then
        return
      end

      -- If no formatter is found, fallback to LSP formatting
      require("conform").format({
        async = false,
        lsp_fallback = true,
      })
    else
      -- Format with the closest formatter
      require("conform").format({
        async = false,
        formatters = formatters,
        lsp_fallback = false,
      })
    end
  end,
})

-- Invalidate biome config cache when biome.json is saved
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "biome.json",
  callback = function(args)
    biome_config_cache[args.file] = nil
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })

-- vim.api.nvim_create_user_command("Format", function(args)
--   local range = nil
--   if args.count ~= -1 then
--     local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
--     range = {
--       start = { args.line1, 0 },
--       ["end"] = { args.line2, end_line:len() },
--     }
--   end
--   require("conform").format({ async = true, lsp_fallback = true, range = range })
-- end, { range = true })
