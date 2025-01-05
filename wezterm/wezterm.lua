local Config = require("config")

local conf = Config:init()
    :append(require("config.appearance"))
    :append(require("config.bindings"))
    :append(require("config.domains"))
    :append(require("config.fonts"))
    :append(require("config.general"))
    :append(require("config.launch")).options

local tabbar = require("plugins.tabbar")
tabbar.apply_to_config(conf, {
    position = "top",
    modules = {
        username = { enabled = true },
        pane = { enabled = true },
        workspace = { enabled = false },
        leader = { enabled = true },
        cwd = { enabled = true, color = 5 },
    },
})

return conf
