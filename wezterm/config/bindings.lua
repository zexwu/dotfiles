local wezterm = require("wezterm")
local act = wezterm.action

local mod = {}

mod.SUPER = "SUPER"
mod.SUPER_REV = "SUPER|CTRL"

local keys = {
    -- misc/useful --
    { key = "F1", mods = "NONE", action = "ActivateCopyMode" },
    { key = "F2", mods = "NONE", action = act.ActivateCommandPalette },
    { key = "F3", mods = "NONE", action = act.ShowLauncher },
    { key = "F4", mods = "NONE", action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },
    {
        key = "F5",
        mods = "NONE",
        action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
    },
    { key = "f", mods = "ALT|SHIFT", action = act.ToggleFullScreen },
    { key = "F12", mods = "NONE", action = act.ShowDebugOverlay },
    { key = "f", mods = mod.SUPER, action = act.Search({ CaseInSensitiveString = "" }) },
    {
        key = "u",
        mods = mod.SUPER,
        action = wezterm.action.QuickSelectArgs({
            label = "open url",
            patterns = {
                "\\((https?://\\S+)\\)",
                "\\[(https?://\\S+)\\]",
                "\\{(https?://\\S+)\\}",
                "<(https?://\\S+)>",
                "\\bhttps?://\\S+[)/a-zA-Z0-9-]+",
            },
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.log_info("opening: " .. url)
                wezterm.open_with(url)
            end),
        }),
    },

    -- cursor movement --
    { key = "LeftArrow", mods = mod.SUPER, action = act.SendString("\x1bOH") },
    { key = "RightArrow", mods = mod.SUPER, action = act.SendString("\x1bOF") },
    { key = "Backspace", mods = mod.SUPER, action = act.SendString("\x15") },

    -- copy/paste --
    { key = "c", mods = mod.SUPER, action = act.CopyTo("Clipboard") },
    { key = "v", mods = mod.SUPER, action = act.PasteFrom("Clipboard") },

    -- tabs --
    -- tabs: spawn+close
    { key = "t", mods = mod.SUPER, action = act.SpawnTab("DefaultDomain") },
    { key = "w", mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },
    {
        key = "e",
        mods = mod.SUPER,
        action = act.PromptInputLine({
            description = "Enter new name for tab",
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        }),
    },

    -- tabs: navigation
    { key = "[", mods = mod.SUPER, action = act.ActivateTabRelative(-1) },
    { key = "]", mods = mod.SUPER, action = act.ActivateTabRelative(1) },

    -- { key = '[',          mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
    -- { key = ']',          mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

    -- window --
    -- spawn windows
    { key = "n", mods = mod.SUPER, action = act.SpawnWindow },

    -- panes --
    -- panes: split panes
    {
        key = [[-]],
        mods = mod.SUPER,
        action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = [[\]],
        mods = mod.SUPER,
        action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },

    -- panes: zoom+close pane
    { key = "Enter", mods = mod.SUPER, action = act.TogglePaneZoomState },
    { key = "w", mods = mod.SUPER, action = act.CloseCurrentPane({ confirm = false }) },

    -- panes: navigation
    { key = "k", mods = mod.SUPER, action = act.ActivatePaneDirection("Up") },
    { key = "j", mods = mod.SUPER, action = act.ActivatePaneDirection("Down") },
    { key = "h", mods = mod.SUPER, action = act.ActivatePaneDirection("Left") },
    { key = "l", mods = mod.SUPER, action = act.ActivatePaneDirection("Right") },
    {
        key = "0",
        mods = mod.SUPER,
        action = act.PaneSelect({ alphabet = "1234567890", mode = "SwapWithActiveKeepFocus" }),
    },
    { key = "-", mods = "SUPER|SHIFT" , action = wezterm.action.DecreaseFontSize },
    { key = "=", mods = "SUPER|SHIFT" , action = wezterm.action.IncreaseFontSize },
    -- panes: resize
    { key = "k", mods = "SUPER|SHIFT", action = act.AdjustPaneSize({ "Up", 2 }) },
    { key = "j", mods = "SUPER|SHIFT", action = act.AdjustPaneSize({ "Down", 2 }) },
    { key = "h", mods = "SUPER|SHIFT", action = act.AdjustPaneSize({ "Left", 2 }) },
    { key = "l", mods = "SUPER|SHIFT", action = act.AdjustPaneSize({ "Right", 2 }) },
}

local mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = act.OpenLinkAtMouseCursor,
    },
}

return {
    disable_default_key_bindings = true,
    leader = { key = "Space", mods = mod.SUPER_REV },
    keys = keys,
    mouse_bindings = mouse_bindings,
}
