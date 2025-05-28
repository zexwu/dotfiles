local wezterm = require("wezterm")

-- local font = "FiraCode Nerd Font Mono"
local font = "JetBrainsMono Nerd Font"
local font_size = 16

return {
    font = wezterm.font_with_fallback({ { family = font, weight = 350 }, { family = "SimSong" } }),
    font_size = font_size,

    cell_width = 0.95,
    --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
    -- freetype_load_target = "Normal", ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
    -- freetype_render_target = "Normal", ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
    font_rules = {
        {
            intensity = "Normal",
            italic = false,
            font = wezterm.font({
                family = font,
            }),
        },
    },
}
