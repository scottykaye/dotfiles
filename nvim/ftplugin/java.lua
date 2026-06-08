local jdtls = require("jdtls")

-- Determine OS-specific config dir for jdtls
local os_config = "linux"
if vim.fn.has("mac") == 1 then
  os_config = "mac"
elseif vim.fn.has("win32") == 1 then
  os_config = "win"
end

local mason_registry = vim.fn.stdpath("data") .. "/mason"
local jdtls_path = mason_registry .. "/packages/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- Per-project workspace directory (jdtls stores index/metadata here)
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

-- Discover debug/test extension bundles installed by Mason
local bundles = {}

local java_debug_path = mason_registry .. "/packages/java-debug-adapter"
local java_debug_jar = vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar")
if java_debug_jar ~= "" then
  table.insert(bundles, java_debug_jar)
end

local java_test_path = mason_registry .. "/packages/java-test"
local java_test_jars = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", true), "\n")
for _, jar in ipairs(java_test_jars) do
  if jar ~= "" then
    table.insert(bundles, jar)
  end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", launcher_jar,
    "-configuration", jdtls_path .. "/config_" .. os_config,
    "-data", workspace_dir,
  },

  root_dir = require("jdtls.setup").find_root({ "gradlew", ".git", "mvnw", "pom.xml", "build.gradle" }),

  capabilities = capabilities,

  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.Assert.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
    },
  },

  init_options = {
    bundles = bundles,
  },

  on_attach = function(client, bufnr)
    -- Set up DAP integration after jdtls attaches
    jdtls.setup_dap({ hotcodereplace = "auto" })

    local opts = { buffer = bufnr }

    -- Java-specific keybindings (<leader>j prefix)
    vim.keymap.set("n", "<leader>jo", jdtls.organize_imports,
      vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
    vim.keymap.set("n", "<leader>jv", jdtls.extract_variable,
      vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
    vim.keymap.set("v", "<leader>jv", function() jdtls.extract_variable(true) end,
      vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
    vim.keymap.set("n", "<leader>jc", jdtls.extract_constant,
      vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
    vim.keymap.set("v", "<leader>jc", function() jdtls.extract_constant(true) end,
      vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
    vim.keymap.set("v", "<leader>jm", function() jdtls.extract_method(true) end,
      vim.tbl_extend("force", opts, { desc = "Extract Method" }))
    vim.keymap.set("n", "<leader>jt", jdtls.test_nearest_method,
      vim.tbl_extend("force", opts, { desc = "Test Nearest Method" }))
    vim.keymap.set("n", "<leader>jT", jdtls.test_class, vim.tbl_extend("force", opts, { desc = "Test Class" }))
    vim.keymap.set("n", "<leader>ju", "<cmd>JdtUpdateConfig<cr>",
      vim.tbl_extend("force", opts, { desc = "Update Project Config" }))
  end,
}

jdtls.start_or_attach(config)
