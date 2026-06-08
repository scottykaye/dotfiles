require("mason").setup()
vim.keymap.set("n", "<leader>cm", ":Mason<CR>", { noremap = true, silent = true })

-- Auto-install debug/test packages for Java
local ensure_installed = { "java-debug-adapter", "java-test" }
local mr = require("mason-registry")
mr.refresh(function()
  for _, pkg_name in ipairs(ensure_installed) do
    local pkg = mr.get_package(pkg_name)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end)
