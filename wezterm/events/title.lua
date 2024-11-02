local wezterm = require("wezterm")
local M = {}
local _set_process_name = function(s)
	local a = string.gsub(s, "(.*[/\\])(.*)", "%2")
    return a
end

local _set_title = function(process_name, base_title, max_width, inset)
	local title
	inset = inset or 6

	if process_name:len() > 0 and not(process_name == base_title) then
		title = " " .. process_name .. " " .. base_title .. " "
	else
		title = " " .. base_title .. " "
	end

	if title:len() > max_width - inset then
		local diff = title:len() - max_width + inset
		title = wezterm.truncate_right(title, title:len() - diff)
	end
	return title
end

local tab_title = function(tab_info, max_width)
	local process_name = _set_process_name(tab_info.active_pane.foreground_process_name)
	local title = _set_title(process_name, tab_info.active_pane.title, max_width, 0)
	if title and #title > 0 then
		return " " .. tostring(tab_info.tab_index + 1) .. title
	end
	return " " .. tostring(tab_info.tab_index + 1) .. tab_info.active_pane.title
end


M.setup = function()
	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local title = tab_title(tab, max_width)
        if tab.is_active then
            return "[" .. title .. "]"
        end
        return title
	end)
end
return M
