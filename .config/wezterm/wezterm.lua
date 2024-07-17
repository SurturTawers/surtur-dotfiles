local wezterm = require("wezterm")
local config = {}

config.color_scheme = "MaterialDark"

--[[
config.colors = {
	foreground = "silver",
	background = "black",
	cursor_bg = "#52ad80",
	cursor_fg = "black",
}
config. = 
config. = 
config. = 
config. = 
config. = 
config. = 
config. = 
config. = 
--]]

config.font = wezterm.font("JetBrains Mono")
config.font_size = 12.0
config.text_background_opacity = 0.5

config.window_background_opacity = 0.75
config.window_padding = {
	left = 0,
	right = 5,
	top = 0,
	bottom = 0,
}

config.window_frame = {
	font_size = 12.0,
}

config.enable_scroll_bar = true

return config
