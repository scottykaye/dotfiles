-- Colorscheme persistence
-- Saves your colorscheme choice and restores it on startup

local M = {}

local colorscheme_file = vim.fn.stdpath("data") .. "/colorscheme.txt"

-- Save colorscheme when it changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local file = io.open(colorscheme_file, "w")
    if file then
      file:write(vim.g.colors_name or "")
      file:close()
    end
  end,
})

-- Load saved colorscheme or fallback to default
function M.load()
  local file = io.open(colorscheme_file, "r")
  local scheme = nil

  if file then
    scheme = file:read("*l")
    file:close()
  end

  -- Use saved scheme or fallback to rose-pine
  scheme = (scheme and scheme ~= "") and scheme or "rose-pine"

  local ok, err = pcall(vim.cmd, "colorscheme " .. scheme)
  if not ok then
    vim.notify("Failed to load colorscheme: " .. scheme .. "\n" .. err, vim.log.levels.WARN)
    vim.cmd("colorscheme rose-pine")
  end
end

return M
