local wezterm = require("wezterm")
local colors, _ = wezterm.color.load_scheme("/Users/zexwu/.config/wezterm/colors/tokyonight_storm.toml")
local M = {}

M.separator_char = "~"

M.colors = {
	-- date_fg = colors.foreground,
	-- date_bg = colors.background,
	-- date_fg = "#aaaaaa",
	-- date_fg = "#7aa2f7",
	date_fg = "#a9b1d6",
	date_bg = "rgb(0, 0, 0, 0)",
	separator_fg = "#a9b1d6",
	separator_bg = "rgb(0, 0, 0, 0)", }

M.cells = {} -- wezterm FormatItems (ref: https://wezfurlong.org/wezterm/config/lua/wezterm/format.html)

---@param text string
---@param icon string
---@param fg string
---@param bg string
---@param separate boolean
M.push = function(text, icon, fg, bg, separate)
	table.insert(M.cells, { Foreground = { Color = fg } })
	table.insert(M.cells, { Background = { Color = bg } })
	table.insert(M.cells, { Attribute = { Intensity = "Bold" } })
	table.insert(M.cells, { Text = icon .. " " .. text .. " " })

	if separate then
		table.insert(M.cells, { Foreground = { Color = M.colors.separator_fg } })
		table.insert(M.cells, { Background = { Color = M.colors.separator_bg } })
		table.insert(M.cells, { Text = M.separator_char })
	end

	table.insert(M.cells, "ResetAttributes")
end

M.set_date = function()
	local date = wezterm.strftime(" %a %H:%M")
	M.push(date, "", M.colors.date_fg, M.colors.date_bg, true)
end

M.setup = function()
	wezterm.on("update-right-status", function(window, _pane)
		M.cells = {}
		M.set_date()

		window:set_right_status(wezterm.format(M.cells))
	end)
end

return M
