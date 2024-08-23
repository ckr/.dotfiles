-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"

config.font_size = 12
config.font = wezterm.font("MesloLGM Nerd Font", { weight = "Medium" })
config.font = wezterm.font_with_fallback({ "JetBrains Mono" })

config.enable_tab_bar = false
config.macos_window_background_blur = 30
config.window_background_opacity = 0.90
config.window_decorations = "RESIZE"
-- and finally, return the configuration to wezterm
return config
