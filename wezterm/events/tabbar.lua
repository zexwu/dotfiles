local wez = require("wezterm")
local config = {
	position = "bottom",
	max_width = 32,
	padding = {
		left = 1,
		right = 1,
	},
	separator = {
		space = 1,
		left_icon = wez.nerdfonts.fa_long_arrow_right,
		right_icon = wez.nerdfonts.fa_long_arrow_left,
		field_icon = wez.nerdfonts.indent_line,
	},
	modules = {
		tabs = {
			active_tab_fg = 4,
			inactive_tab_fg = 6,
		},
		workspace = {
			enabled = false,
			icon = wez.nerdfonts.cod_window,
			color = 8,
		},
		leader = {
			enabled = false,
			icon = wez.nerdfonts.oct_rocket,
			color = 2,
		},
		pane = {
			enabled = false,
			icon = wez.nerdfonts.cod_multiple_windows,
			color = 7,
		},
		username = {
			enabled = false,
			icon = wez.nerdfonts.fa_user,
			color = 6,
		},
		hostname = {
			enabled = false,
			icon = wez.nerdfonts.cod_server,
			color = 8,
		},
		clock = {
			enabled = false,
			icon = wez.nerdfonts.md_calendar_clock,
			color = 5,
		},
		cwd = {
			enabled = false,
			icon = wez.nerdfonts.oct_file_directory,
			color = 7,
		},
		spotify = {
			enabled = false,
			icon = wez.nerdfonts.fa_spotify,
			color = 3,
			max_width = 64,
			throttle = 15,
		},
	},
}
local bar = wez.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)
