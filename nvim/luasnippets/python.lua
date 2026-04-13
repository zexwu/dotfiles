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

local lb = { condition = line_begin }

local nodes = {
    s(
        "basic",
        t({
            "from pathlib import Path",
            "",
            "import matplotlib.pyplot as plt",
            "import numpy as np",
            "from astropy.table import Table",
            "",
            "plt.style.use('~/zexwu_lib/zexwu.mplstyle')",
            "",
        }),
        lb
    ),
    s(
        "pd",
        t({
            "from pathlib import Path",
            "",
            "import matplotlib.pyplot as plt",
            "import numpy as np",
            "import pandas as pd",
            "",
            "plt.style.use('~/zexwu_lib/zexwu.mplstyle')",
            "pd.set_option('display.max_columns', None)",
            "",
        }),
        lb
    ),
    s(
        "oifits",
        t({
            "from oifits import OI_VIS, OI_FLUX, OI_ARRAY, OI_T3, OI_WAVELENGTH, GRAVITY_SC",
        }),
        lb
    ),
    s(
        "coord",
        t({
            "from astropy.table import Table",
            "from astropy.coordinates import SkyCoord",
            "import astropy.units as u",
        }),
        lb
    ),
    s(
        "fits",
        t({
            "from astropy.io import fits",
        }),
        lb
    ),
    s(
        "main",
        t({
            "if __name__ == '__main__':",
            "    pass",
        }),
        lb
    ),
    s(
        "args",
        t({
            "import argparse",
            "",
            "parser = argparse.ArgumentParser()",
            "parser.add_argument('--input', type=str, required=True)",
            "args = parser.parse_args()",
        }),
        lb
    ),
    s(
        "log",
        t({
            "import logging",
            "",
            "logging.basicConfig(",
            "    level=logging.INFO,",
            "    format='%(asctime)s %(levelname)s %(message)s',",
            ")",
            "logger = logging.getLogger(__name__)",
        }),
        lb
    ),
    s(
        "fig",
        t({
            "fig, ax = plt.subplots(figsize=(6, 6))",
        }),
        lb
    ),
    s(
        "figs",
        fmt("fig, axs = plt.subplots({1}, {2}, figsize=({3}, {4}), constrained_layout=True)", {
            i(1, "1"),
            i(2, "2"),
            i(3, "16"),
            i(4, "9"),
        }),
        lb
    ),
    s(
        "hist",
        fmt("ax.hist({1}, bins={2}, histtype='step')", {
            i(1, "x"),
            i(2, "50"),
        }),
        lb
    ),
    s(
        "scat",
        fmt("ax.scatter({1}, {2}, s={3}, alpha={4})", {
            i(1, "x"),
            i(2, "y"),
            i(3, "10"),
            i(4, "0.8"),
        }),
        lb
    ),
    s(
        "errb",
        fmt("ax.errorbar({1}, {2}, yerr={3}, fmt='o', ms={4}, capsize=0)", {
            i(1, "x"),
            i(2, "y"),
            i(3, "yerr"),
            i(4, "3"),
        }),
        lb
    ),
    s(
        "imshow",
        fmt("im = ax.imshow({1}, origin='lower', cmap='{2}')", {
            i(1, "data"),
            i(2, "viridis"),
        }),
        lb
    ),
    s("sfig", fmt("plt.savefig('{1}', dpi=200, bbox_inches='tight')", { i(1, "temp.png") }), lb),
    s("rdcsv", fmt("df = pd.read_csv('{1}')", { i(1, "data.csv") }), lb),
    s("tblr", fmt("tab = Table.read('{1}')", { i(1, "table.fits") }), lb),
    s("tblw", fmt("{1}.write('{2}', overwrite=True)", { i(1, "tab"), i(2, "table.fits") }), lb),
    s(
        "npz",
        fmt("{1} = np.load('{2}', allow_pickle=True)", { i(1, "data"), i(2, "data.npz") }),
        lb
    ),
    s(
        "pathg",
        fmt("{1} = sorted(Path('{2}').glob('{3}'))", {
            i(1, "files"),
            i(2, "."),
            i(3, "*.fits"),
        }),
        lb
    ),
    s(
        "skyc",
        fmt("coord = SkyCoord({1}, {2}, unit='deg', frame='{3}')", {
            i(1, "ra"),
            i(2, "dec"),
            i(3, "icrs"),
        }),
        lb
    ),
    s(
        "sigma",
        fmta(
            [[
from astropy.stats import sigma_clip

clipped = sigma_clip(<data>, sigma=<sigma>, maxiters=<iters>)
]],
            {
                data = i(1, "data"),
                sigma = i(2, "3"),
                iters = i(3, "5"),
            }
        ),
        lb
    ),
   s(
        "ascii",
        t({
            "from astropy.io import ascii",
            "",
        }),
        lb
    ),
    s(
        "#-",
        fmt("# ---- {1} ----", {
            i(1, "Section"),
        }),
        lb
    ),
    s(
        "skip",
        t({
            "# fmt: skip",
        }),
        lb
    ),
}

return nodes
