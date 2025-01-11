local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Ayu Mirage'

config.default_domain = 'WSL:Ubuntu'

config.use_ime = true
config.font_size = 14
config.enable_scroll_bar = true
config.default_cursor_style = 'BlinkingUnderline'
config.window_close_confirmation = 'NeverPrompt'

local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

return config
