local wezterm = require("wezterm")
local colorschemes = require("colorschemes")
local config = {}

config.color_scheme = colorschemes.mirage
--IF COLORSCHEME IS CUSTOM
--config.colors = colorschemes.custom.gentleman.test

config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false
config.window_background_opacity = 0.83
config.window_frame = {
	font_size = 11.0,
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.text_background_opacity = 0.5
config.font = wezterm.font("JetBrains Mono")
config.font_size = 12.0

return config
