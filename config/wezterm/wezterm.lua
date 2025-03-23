-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.automatically_reload_config = true

config.send_composed_key_when_left_alt_is_pressed = false

-- and finally, return the configuration to wezterm
return config
