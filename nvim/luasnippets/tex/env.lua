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

local envs = {
    fig = [[
\begin{figure}[<>]
\centering
\includegraphics[width=0.8\textwidth]{<>}
\caption{<>}
\label{fig:<>}
\end{figure}
            ]],
    table = [[
\begin{table}[<>]
	\centering
	\caption{<>}
	\label{tab:<>}
	\begin{tabular}{<>}
     
	\end{tabular}
\end{table}
    ]],
    env = [[
\begin{<>}
    <>
\end{<>}
    ]],
}

local function gname(args, parent, user_args)
    local prefix, _ = args[1][1]:match("([^.]+).([^.]+)")
    return prefix
end

local nodes = {
    s(
        { trig = "fig" },
        fmta(envs.fig, {
            i(1, { "H" }),
            i(2),
            i(3),
            f(gname, { 2 }, {}),
        }),
        { condition = line_begin }
    ),
    s(
        { trig = "beg" },
        fmta(envs.env, {
            i(1),
            i(2),
            rep(1),
        }),
        { condition = line_begin }
    ),
    s(
        { trig = "table" },
        fmta(envs.table, {
            i(1, { "ht!" }),
            i(2),
            rep(2),
            -- f(gname, { 2 }, {}),
            i(3),
        }),
        { condition = line_begin }
    ),
    s({ trig = "hll", snippetType = "autosnippet" }, { t("\\hline") }, { condition = line_begin }),
}
return nodes
