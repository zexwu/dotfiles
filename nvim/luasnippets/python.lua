local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local nodes = {
    s(
        "tab",
        t({ "import numpy as np", "import pandas as pd", "from astropy.table import Table" }),
        { condition = line_begin }
    ),
    s(
        "basic",
        t({
            "import numpy as np",
            "import matplotlib.pyplot as plt",
            'plt.rcParams["font.size"] = "12"',
            "",
        }),
        { condition = line_begin }
    ),
    s(
        "coord",
        t({
            "from astropy.table import Table",
            "from astropy.coordniates import Skycoord",
            "import astropy.units as u",
        }),
        { condition = line_begin }
    ),

    s(
        "fig",
        t({
            "fig, ax = plt.subplots(figsize=(6, 6))",
        }),
        { condition = line_begin }
    ),
    s(
        "sfig",
        fmt(
            [[ 
fig.tight_layout()
plt.savefig({1}, bbox_inches="tight", dpi=200)
        ]],
            { i(1, '"temp.png"') }
        ),
        { condition = line_begin }
    ),
    s(
        "---",
        t({
            "# ================================================================================",
        }),
        { condition = line_begin }
    ),
}

return nodes
