local wezterm = require "wezterm";

local config = wezterm.config_builder()

config.color_scheme = 'Kanagawa (Gogh)'
config.window_background_opacity = 0.7
config.default_workspace = 'kastor'

config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5
}

return config
