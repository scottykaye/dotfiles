local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 14

config.enable_tab_bar = false

config.window_decorations = "RESIZE"


local scottykayeTheme = {
  foreground = "#ebe4f2",
  background = "#241b2e",
  cursor_bg = "#FFBD16",
  cursor_border = "#FFBD16",
  cursor_fg = "#011423",
  selection_bg = "#FFBD16",
  selection_fg = "#333333",
  ansi = { "#111423", "#ff5555", "#2ff54c", "#FFBD16", "#bd93f9", "#ff79c6", "#8be9fd", "#CBE0F0" },
  brights = { "#214963", "#ff5555", "#2ff54c", "#FFBD16", "#bd93f9", "#ff79c6", "#8be9fd", "#CBE0F0" },
}

config.colors = scottykayeTheme

config.window_background_opacity = 0.9
config.macos_window_background_blur = 10



config.set_environment_variables = {
  PATH = os.getenv("PATH"),
}

-- Set leader key
config.leader = { key = "b", mods = "OPT", timeout_milliseconds = 1500 }

-- This is where you actually apply your config choices

config.initial_cols = 120
config.initial_rows = 32
config.inactive_pane_hsb = { saturation = 0.5, brightness = 0.9 }

-- Change the fontsize
-- config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", italic = false })
-- config.font_size = 14
-- config.line_height = 1.2

--- font for tabs
config.window_frame = {
  font = wezterm.font({ family = "Noto Sans", weight = "Regular" }),
}
-- Set scrollback lines
config.scrollback_lines = 10240

-- tab bar
config.adjust_window_size_when_changing_font_size = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"

-- Slightly transparent and blurred background
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

-- Mouse settings
config.pane_focus_follows_mouse = true

-- Set cursor styles
config.default_cursor_style = "SteadyBlock"

-- Set visual bell and audio bell
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = "CursorColor",
}

local function get_current_working_dir(tab)
  local pane = tab.active_pane
  if not pane or not pane.current_working_dir then
    return ""
  end

  local cwd_uri = pane.current_working_dir
  local cwd = cwd_uri:sub(8) -- remove "file://"
  local home = os.getenv("HOME")
  cwd = cwd:gsub(home, "~")  -- shorten home dir
  return cwd:match("([^/]+)$") or cwd
end


-- set tab-title to current dir if not set explicitly
wezterm.on("format-tab-title", function(tab)
  local cwd = get_current_working_dir(tab)
  local title = tab.tab_title
  local num = tab.tab_index + 1

  if title and #title > 0 then
    return string.format("  %s %s  ", num, title)
  end

  return string.format("  %s %s  ", num, cwd)
end)

config.keys = {
  { key = "d",          mods = "SHIFT|CMD", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "d",          mods = "CMD",       action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "DownArrow",  mods = "SHIFT",     action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "UpArrow",    mods = "SHIFT",     action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "LeftArrow",  mods = "SHIFT",     action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "SHIFT",     action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "w",          mods = "CMD",       action = act.CloseCurrentPane({ confirm = true }) },
  { key = "r",          mods = "LEADER",    action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
  { key = "Enter",      mods = "LEADER",    action = act.ActivateCopyMode },
  { key = "c",          mods = "CMD",       action = act.CopyTo("Clipboard") },
  { key = "n",          mods = "CMD",       action = act.SpawnWindow },
  { key = "v",          mods = "CMD",       action = act.PasteFrom("Clipboard") },
  { key = 'LeftArrow',  mods = 'CTRL|ALT',  action = wezterm.action.ActivatePaneDirection('Left') },
  { key = 'RightArrow', mods = 'CTRL|ALT',  action = wezterm.action.ActivatePaneDirection('Right') },
  { key = 'UpArrow',    mods = 'CTRL|ALT',  action = wezterm.action.ActivatePaneDirection('Up') },
  { key = 'DownArrow',  mods = 'CTRL|ALT',  action = wezterm.action.ActivatePaneDirection('Down') },
  {
    key = "RightArrow",
    mods = "CMD|CTRL",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = "LeftArrow",
    mods = "CMD|CTRL",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 'Enter',
    mods = 'SHIFT|CMD',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = ",",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
}


config.mouse_bindings = {
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}


return config
