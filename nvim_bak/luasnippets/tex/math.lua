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
local tex_utils = {}
tex_utils.in_mathzone = function() -- math context detection
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex_utils.in_text = function()
    return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function() -- comment detection
    return vim.fn["vimtex#syntax#in_comment"]() == 1
end
tex_utils.in_env = function(name) -- generic environment detection
    local is_inside = vim.fn["vimtex#env#is_inside"](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function() -- equation environment detection
    return tex_utils.in_env("equation")
end
tex_utils.in_itemize = function() -- itemize environment detection
    return tex_utils.in_env("itemize")
end
tex_utils.in_tikz = function() -- TikZ picture environment detection
    return tex_utils.in_env("tikzpicture")
end

local get_visual = function(args, parent)
    if #parent.snippet.env.SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
    else -- If SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

local nodes = {
    s(
        { trig = "dm", snippetType = "autosnippet" },
        { t({ "\\[", "" }), i(1), t({ "", "\\]" }) },
        { condition = line_begin }
    ),
    s(
        { trig = "([^%a])mk", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>$<>$ ", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),
    -- s({ trig = 'mk', snippetType = 'autosnippet' },
    --     fmta(
    --         "$<>$ <>",
    --         {
    --             i(1),
    --             i(2)
    --         }
    --     )
    -- ),
    -- Another take on the fraction snippet without using a regex trigger
    -- s({ trig = "ff", snippetType = "autosnippet" },
    --     fmta(
    --         "\\frac{<>}{<>}",
    --         {
    --             i(1),
    --             i(2),
    --         }
    --     ),
    --     { condition = tex_utils.in_mathzone }
    -- ),
    s(
        { trig = "([^%a])ff", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta([[<>\frac{<>}{<>}]], {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex_utils.in_mathzone }
    ),
    s(
        { trig = "sd", snippetType = "autosnippet", wordTrig = false },
        fmta("_{\\mathrm{<>}}", { d(1, get_visual) }),
        { condition = tex_utils.in_mathzone }
    ),

    s(
        { trig = "([^%a])tt", regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\text{<>} ", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
        }),
        { condition = tex_utils.in_mathzone }
    ),

    s({ trig = ",,", snippetType = "autosnippet" }, { t(",\\, ") }, { condition = tex_utils.in_mathzone }),
    s(
        { trig = "([^%a])sss", regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\si{<>} ", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
        }),
        { condition = tex_utils.in_mathzone }
    ),
    s({ trig = "=>", snippetType = "autosnippet" }, { t("\\implies ") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "=<", snippetType = "autosnippet" }, { t("\\implied ") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "dd", snippetType = "autosnippet" }, { t("\\mathrm{d} ") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "!=", snippetType = "autosnippet" }, { t("\\neq ") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "sr", snippetType = "autosnippet" }, { t("^2 ") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "cb", snippetType = "autosnippet" }, { t("^3 ") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "ooo", snippetType = "autosnippet" }, { t("\\infty ") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "<=", snippetType = "autosnippet" }, { t("\\le") }, { condition = tex_utils.in_mathzone }),
    s({ trig = ">=", snippetType = "autosnippet" }, { t("\\ge") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "EE", snippetType = "autosnippet" }, { t("\\exist") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "xx", snippetType = "autosnippet" }, { t("\\times ") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "->", snippetType = "autosnippet" }, { t("\\to") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "!>", snippetType = "autosnippet" }, { t("\\mapsto") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "inv", snippetType = "autosnippet" }, { t("^{-1}") }, { condition = tex_utils.in_mathzone }),
    s({ trig = ">>", snippetType = "autosnippet" }, { t("\\gg") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "<<", snippetType = "autosnippet" }, { t("\\ll") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "~", snippetType = "autosnippet" }, { t("\\sim") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "inn", snippetType = "autosnippet" }, { t("\\in") }, { condition = tex_utils.in_mathzone }),
    s({ trig = "RR", snippetType = "autosnippet" }, { t("\\R") }, { condition = tex_utils.in_mathzone }),
    s(
        { trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t("0"),
        }),
        { condition = tex_utils.in_mathzone }
    ),
    s(
        { trig = "([%a%)%]%}])ii", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t("i"),
        }),
        { condition = tex_utils.in_mathzone }
    ),
    s(
        { trig = "([%a%)%]%}])jj", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t("j"),
        }),
        { condition = tex_utils.in_mathzone }
    ),
    s(
        { trig = "([%a%)%]%}])bar", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("\\overline{<>} ", {
            f(function(_, snip)
                return snip.captures[1]
            end),
        }),
        { condition = tex_utils.in_mathzone }
    ),
    s(
        { trig = "([%a%)%]%}])([%d])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>_<>", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            f(function(_, snip)
                return snip.captures[2]
            end),
        }),
        { condition = tex_utils.in_mathzone }
    ),
    s(
        { trig = "conj", snippetType = "autosnippet" },
        fmta("\\overline{<>} ", {
            i(1),
        }),
        { condition = tex_utils.in_mathzone }
    ),
    s(
        { trig = "lr(", snippetType = "autosnippet" },
        fmta("\\left(<>\\right) ", {
            i(1),
        }),
        { condition = tex_utils.in_mathzone }
    ),
    s(
        { trig = "lr[", snippetType = "autosnippet" },
        fmta("\\left[<>\\right] ", {
            i(1),
        }),
        { condition = tex_utils.in_mathzone }
    ),
    s(
        { trig = "lr{", snippetType = "autosnippet" },
        fmta("\\left{<>\\right} ", {
            i(1),
        }),
        { condition = tex_utils.in_mathzone }
    ),
}

local greek = {
    "alpha",
    "beta",
    "gamma",
    "delta",
    "epsilon",
    "zeta",
    "theta",
    "lota",
    "kappa",
    "lambda",
    "mu",
    "nu",
    "xi",
    "omicron",
    "pi",
    "rho",
    "sigma",
    "tau",
    "upsilon",
    "phi",
    "chi",
    "psi",
    "omega",
    "iff",
    "log",
    "sin",
    "cos",
    "tan",
    "varphi",
    "sec",
    "csc",
    "arctan",
    "arccot",
    "arcsin",
    "arccos",
    "arcsec",
    "arccsc",
    "bm"
}

local greekU = {
    "Alpha",
    "Beta",
    "Bamma",
    "Delta",
    "Epsilon",
    "Zeta",
    "Eta",
    "Theta",
    "Lota",
    "Kappa",
    "Lambda",
    "Mu",
    "Nu",
    "Xi",
    "Omicron",
    "Pi",
    "Rho",
    "Sigma",
    "Tau",
    "Upsilon",
    "Phi",
    "chi",
    "Psi",
    "Omega",
}

for _, v in pairs(greek) do
    local tg = "([^\\])" .. v
    local ss = "<>\\" .. v
    local gnode = s(
        { trig = tg, regTrig = true, snippetType = "autosnippet", wordTrig = false },
        fmta(ss, {
            f(function(_, snip)
                return snip.captures[1]
            end),
        }),
        { condition = tex_utils.in_mathzone }
    )
    table.insert(nodes, gnode)
end
for _, v in pairs(greekU) do
    local tg = "([^\\])" .. v
    local ss = "<>\\" .. v
    local gnode = s(
        { trig = tg, regTrig = true, snippetType = "autosnippet", wordTrig = false },
        fmta(ss, {
            f(function(_, snip)
                return snip.captures[1]
            end),
        }),
        { condition = tex_utils.in_mathzone }
    )
    table.insert(nodes, gnode)
end

local gnode = s(
    { trig = "([^\\h])eta", regTrig = true, snippetType = "autosnippet", wordTrig = false },
    fmta("<>\\eta ", {
        f(function(_, snip)
            return snip.captures[1]
        end),
    }),
    { condition = tex_utils.in_mathzone }
)
table.insert(nodes, gnode)
return nodes
