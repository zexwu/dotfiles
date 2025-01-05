local wezterm = require("wezterm")

local colors, _ = wezterm.color.load_scheme("/Users/zexwu/.config/wezterm/colors/tokyonight_storm.toml")

return {
    animation_fps = 60,
    max_fps = 60,
    front_end = "WebGpu",
    webgpu_power_preference = "HighPerformance",

    -- color scheme
    colors = colors,

    -- background
    background = {
        {
            source = { Color = colors.background },
            height = "100%",
            width = "100%",
            opacity = 0.85,
        },
    },

    -- scrollbar
    enable_scroll_bar = false,

    -- tab bar
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = false,
    use_fancy_tab_bar = false,
    tab_max_width = 50,
    show_tab_index_in_tab_bar = true,
    switch_to_last_active_tab_when_closing_tab = false,

    -- window
    window_padding = {
        left = 10,
        right = 1,
        top = 5,
        bottom = 1,
    },
    window_close_confirmation = "NeverPrompt",
    -- window_decorations = "RESIZE",
    window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW",
    macos_window_background_blur = 40,
    inactive_pane_hsb = {
        saturation = 1,
        brightness = 1,
    },

    -- cursor
    cursor_thickness = 1,
    force_reverse_video_cursor = true,
    default_cursor_style = "SteadyBlock",
}
