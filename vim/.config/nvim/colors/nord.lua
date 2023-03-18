-- Port of https://github.com/arcticicestudio/nord-vim

local nord0_gui = "#2E3440"
local nord1_gui = "#3B4252"
local nord2_gui = "#434C5E"
local nord3_gui = "#4C566A"
local nord3_gui_bright = "#616E88"
local nord4_gui = "#D8DEE9"
local nord5_gui = "#E5E9F0"
local nord6_gui = "#ECEFF4"
local nord7_gui = "#8FBCBB"
local nord8_gui = "#88C0D0"
local nord9_gui = "#81A1C1"
local nord10_gui = "#5E81AC"
local nord11_gui = "#BF616A"
local nord12_gui = "#D08770"
local nord13_gui = "#EBCB8B"
local nord14_gui = "#A3BE8C"
local nord15_gui = "#B48EAD"

local nord1_term = 0
local nord3_term = 8
local nord5_term = 7
local nord6_term = 15
local nord7_term = 14
local nord8_term = 6
local nord9_term = 4
local nord10_term = 12
local nord11_term = 1
local nord12_term = 11
local nord13_term = 3
local nord14_term = 2
local nord15_term = 5

vim.g.terminal_color_0 = nord1_gui
vim.g.terminal_color_1 = nord11_gui
vim.g.terminal_color_2 = nord14_gui
vim.g.terminal_color_3 = nord13_gui
vim.g.terminal_color_4 = nord9_gui
vim.g.terminal_color_5 = nord15_gui
vim.g.terminal_color_6 = nord8_gui
vim.g.terminal_color_7 = nord5_gui
vim.g.terminal_color_8 = nord3_gui
vim.g.terminal_color_9 = nord11_gui
vim.g.terminal_color_10 = nord14_gui
vim.g.terminal_color_11 = nord13_gui
vim.g.terminal_color_12 = nord9_gui
vim.g.terminal_color_13 = nord15_gui
vim.g.terminal_color_14 = nord7_gui
vim.g.terminal_color_15 = nord6_gui

-- +---------------+
-- +    Config     +
-- +---------------+
local bold = true
local underline = true
local italic = true
-- local italicize_comments = false
local uniform_status_lines = false
local bold_vertical_split_line = false
local cursor_line_number_background = false
local uniform_diff_background = true -- change in vim default which is false

-- +---------------+
-- + UI Components +
-- +---------------+

-- +--- Attributes ---+
vim.api.nvim_set_hl(0, "Bold", { bold = bold })
vim.api.nvim_set_hl(0, "Italic", { italic = italic })
vim.api.nvim_set_hl(0, "Underline", { underline = underline })

-- +--- Editor ---+
vim.api.nvim_set_hl(0, "ColorColumn", { bg = nord1_gui, ctermfg = "NONE", ctermbg = nord1_term })
vim.api.nvim_set_hl(0, "Cursor", { fg = nord0_gui, bg = nord4_gui, ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = nord1_gui, ctermfg = "NONE", ctermbg = nord1_term }) -- None?
vim.api.nvim_set_hl(0, "Error", { fg = nord4_gui, bg = nord11_gui, ctermbg = nord11_term })
vim.api.nvim_set_hl(0, "iCursor", { fg = nord0_gui, bg = nord4_gui, ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr", { fg = nord3_gui, bg = "NONE", ctermfg = nord3_term, ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "MatchParen", { fg = nord8_gui, bg = nord3_gui, ctermfg = nord8_term, ctermbg = nord3_term })
vim.api.nvim_set_hl(0, "NonText", { fg = nord2_gui, ctermfg = nord3_term })
vim.api.nvim_set_hl(0, "Normal", { fg = nord4_gui, bg = nord0_gui, ctermfg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = nord4_gui, bg = nord2_gui, ctermfg = "NONE", ctermbg = nord1_term }) -- None?
vim.api.nvim_set_hl(0, "PmenuSbar", { fg = nord4_gui, bg = nord2_gui, ctermfg = "NONE", ctermbg = nord1_term })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = nord8_gui, bg = nord3_gui, ctermfg = nord8_term, ctermbg = nord3_term })
vim.api.nvim_set_hl(0, "PmenuThumb", { fg = nord8_gui, bg = nord3_gui, ctermfg = "NONE", ctermbg = nord3_term })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = nord3_gui, ctermfg = nord3_term })
vim.api.nvim_set_hl(0, "SpellBad", {
	fg = nord11_gui,
	bg = nord0_gui,
	ctermfg = nord11_term,
	ctermbg = "NONE",
	undercurl = true,
	cterm = { undercurl = true },
	sp = nord11_gui,
})
vim.api.nvim_set_hl(0, "SpellCap", {
	fg = nord13_gui,
	bg = nord0_gui,
	ctermfg = nord13_term,
	ctermbg = "NONE",
	undercurl = true,
	cterm = { undercurl = true },
	sp = nord13_gui,
})
vim.api.nvim_set_hl(0, "SpellLocal", {
	fg = nord5_gui,
	bg = nord0_gui,
	ctermfg = nord5_term,
	ctermbg = "NONE",
	undercurl = true,
	cterm = { undercurl = true },
	sp = nord5_gui,
})
vim.api.nvim_set_hl(0, "SpellRare", {
	fg = nord6_gui,
	bg = nord0_gui,
	ctermfg = nord6_term,
	ctermbg = "NONE",
	undercurl = true,
	cterm = { undercurl = true },
	sp = nord6_gui,
})

vim.api.nvim_set_hl(0, "Visual", { bg = nord2_gui, ctermbg = nord1_term })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = nord2_gui, ctermbg = nord1_term })

-- +--- Gutter ---+
vim.api.nvim_set_hl(0, "CursorColumn", { bg = nord1_gui, ctermfg = "NONE", ctermbg = nord1_term })

if cursor_line_number_background then
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = nord4_gui, bg = nord1_gui, ctermfg = "NONE", ctermbg = nord1_term }) -- NONE
else
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = nord4_gui, ctermfg = "NONE" }) -- NONE
end

vim.api.nvim_set_hl(
	0,
	"Folded",
	{ fg = nord3_gui, bg = nord1_gui, ctermfg = nord3_term, ctermbg = nord1_term, bold = true, cterm = { bold = true } }
)
vim.api.nvim_set_hl(0, "FoldColumn", { fg = nord3_gui, bg = nord0_gui, ctermfg = nord3_term, ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { fg = nord1_gui, bg = nord0_gui, ctermfg = nord1_term, ctermbg = "NONE" })

-- +--- Navigation ---+
vim.api.nvim_set_hl(0, "Directory", { fg = nord8_gui, ctermfg = nord8_term, ctermbg = "NONE" })

-- +--- Prompt/Status ---+
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = nord1_gui, ctermfg = nord1_term, ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = nord4_gui, bg = nord11_gui, ctermfg = "NONE", ctermbg = nord11_term })
vim.api.nvim_set_hl(0, "ModeMsg", { fg = nord4_gui })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = nord8_gui, ctermfg = nord8_term })
vim.api.nvim_set_hl(0, "Question", { fg = nord4_gui, ctermfg = "NONE" })

if uniform_status_lines then
	vim.api.nvim_set_hl(0, "StatusLine", { fg = nord8_gui, bg = nord3_gui, ctermfg = nord8_term, ctermbg = nord3_term }) -- NONE
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = nord4_gui, bg = nord3_gui, ctermfg = "NONE", ctermbg = nord3_term }) -- NONE
	vim.api.nvim_set_hl(
		0,
		"StatusLineTerm",
		{ fg = nord8_gui, bg = nord3_gui, ctermfg = nord8_term, ctermbg = nord3_term }
	) -- NONE
	vim.api.nvim_set_hl(
		0,
		"StatusLineTermNC",
		{ fg = nord4_gui, bg = nord3_gui, ctermfg = "NONE", ctermbg = nord3_term }
	) -- NONE
else
	vim.api.nvim_set_hl(0, "StatusLine", { fg = nord8_gui, bg = nord3_gui, ctermfg = nord8_term, ctermbg = nord3_term }) -- NONE
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = nord4_gui, bg = nord1_gui, ctermfg = "NONE", ctermbg = nord1_term }) -- NONE
	vim.api.nvim_set_hl(
		0,
		"StatusLineTerm",
		{ fg = nord8_gui, bg = nord3_gui, ctermfg = nord8_term, ctermbg = nord3_term }
	) -- NONE
	vim.api.nvim_set_hl(
		0,
		"StatusLineTermNC",
		{ fg = nord4_gui, bg = nord1_gui, ctermfg = "NONE", ctermbg = nord1_term }
	) -- NONE
end

vim.api.nvim_set_hl(0, "WarningMsg", { fg = nord0_gui, bg = nord13_gui, ctermfg = nord1_term, ctermbg = nord13_term })
vim.api.nvim_set_hl(0, "WildMenu", { fg = nord8_gui, bg = nord1_gui, ctermfg = nord8_term, ctermbg = nord1_term })

-- +--- Search ---+
vim.api.nvim_set_hl(0, "IncSearch", {
	fg = nord6_gui,
	bg = nord10_gui,
	ctermfg = nord6_term,
	ctermbg = nord10_term,
	underline = true,
	cterm = { underline = true },
})
vim.api.nvim_set_hl(0, "Search", { fg = nord1_gui, bg = nord8_gui, ctermfg = nord1_term, ctermbg = nord8_term }) -- NONE

-- +--- Tabs ---+
vim.api.nvim_set_hl(0, "TabLine", { fg = nord4_gui, bg = nord1_gui, ctermfg = "NONE", ctermbg = nord1_term }) -- NONE
vim.api.nvim_set_hl(0, "TabLineFill", { fg = nord4_gui, bg = nord1_gui, ctermfg = "NONE", ctermbg = nord1_term }) -- NONE
vim.api.nvim_set_hl(0, "TabLineSel", { fg = nord8_gui, bg = nord3_gui, ctermfg = nord8_term, ctermbg = nord3_term }) -- NONE

-- +--- Window ---+
vim.api.nvim_set_hl(0, "Title", { fg = nord4_gui, ctermfg = "NONE" }) -- NONE

if bold_vertical_split_line then
	vim.api.nvim_set_hl(0, "VertSplit", { fg = nord2_gui, bg = nord1_gui, ctermfg = nord3_term, ctermbg = nord1_term }) -- NONE
else
	vim.api.nvim_set_hl(0, "VertSplit", { fg = nord2_gui, bg = nord0_gui, ctermfg = nord3_term, ctermbg = "NONE" }) -- NONE
end

-- +- Diagnostics -+
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = nord13_gui, ctermfg = nord13_term })
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = nord11_gui, ctermfg = nord11_term })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = nord8_gui, ctermfg = nord8_term })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = nord10_gui, ctermfg = nord10_term })
vim.api.nvim_set_hl(
	0,
	"DiagnosticUnderlineWarn",
	{ fg = nord13_gui, ctermfg = nord13_term, undercurl = true, cterm = { undercurl = true } }
)
vim.api.nvim_set_hl(
	0,
	"DiagnosticUnderlineError",
	{ fg = nord11_gui, ctermfg = nord11_term, undercurl = true, cterm = { undercurl = true } }
)
vim.api.nvim_set_hl(
	0,
	"DiagnosticUnderlineInfo",
	{ fg = nord8_gui, ctermfg = nord8_term, undercurl = true, cterm = { undercurl = true } }
)
vim.api.nvim_set_hl(
	0,
	"DiagnosticUnderlineHint",
	{ fg = nord10_gui, ctermfg = nord10_term, undercurl = true, cterm = { undercurl = true } }
)

-- +- Lsp -+
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = nord3_gui, ctermbg = nord3_term })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = nord3_gui, ctermbg = nord3_term })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = nord3_gui, ctermbg = nord3_term })
vim.api.nvim_set_hl(
	0,
	"LspSignatureActiveParameter",
	{ fg = nord8_gui, ctermfg = nord8_term, underline = true, cterm = { underline = true } }
)
vim.api.nvim_set_hl(0, "LspCodeLens", { fg = nord3_gui_bright, ctermfg = nord3_term })


-- +----------------------+
-- + Language Base Groups +
-- +----------------------+
vim.api.nvim_set_hl(0, "Boolean", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "Character", { fg = nord14_gui, ctermfg = nord14_term })
vim.api.nvim_set_hl(
	0,
	"Comment",
	{ fg = nord3_gui_bright, ctermfg = nord3_term, italic = true, cterm = { italic = true } }
)
vim.api.nvim_set_hl(0, "Conceal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "Conditional", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "Constant", { fg = nord4_gui, ctermfg = "NONE" })
vim.api.nvim_set_hl(0, "Decorator", { fg = nord12_gui, ctermfg = nord12_term, link = "Annotation" })
vim.api.nvim_set_hl(0, "Define", { fg = nord9_gui, ctermfg = nord9_term, link = "Macro" })
vim.api.nvim_set_hl(0, "Delimiter", { fg = nord6_gui, ctermfg = nord6_term })
vim.api.nvim_set_hl(0, "Exception", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "Float", { fg = nord15_gui, ctermfg = nord15_term })
vim.api.nvim_set_hl(0, "Function", { fg = nord8_gui, ctermfg = nord8_term })
vim.api.nvim_set_hl(0, "Identifier", { fg = nord4_gui, ctermfg = "NONE", link = "Variable" }) -- NONE
vim.api.nvim_set_hl(0, "Include", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "Keyword", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "Label", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "Number", { fg = nord15_gui, ctermfg = nord15_term })
vim.api.nvim_set_hl(0, "Operator", { fg = nord9_gui, ctermfg = nord9_term }) -- NONE
vim.api.nvim_set_hl(0, "PreProc", { fg = nord9_gui, ctermfg = nord9_term, link = "PreCondit" }) -- NONE
vim.api.nvim_set_hl(0, "Repeat", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "Special", { fg = nord4_gui, ctermfg = "NONE" })
vim.api.nvim_set_hl(0, "SpecialChar", { fg = nord13_gui, ctermfg = nord13_term })
vim.api.nvim_set_hl(
	0,
	"SpecialComment",
	{ fg = nord8_gui, ctermfg = nord8_term, italic = true, cterm = { italic = true } }
)
vim.api.nvim_set_hl(0, "Statement", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "StorageClass", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "String", { fg = nord14_gui, ctermfg = nord14_term })
vim.api.nvim_set_hl(0, "Structure", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "Tag", { fg = nord4_gui })
vim.api.nvim_set_hl(0, "Todo", { fg = nord13_gui, bg = "NONE", ctermfg = nord13_term, ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "Type", { fg = nord9_gui, ctermfg = nord9_term }) -- NONE
vim.api.nvim_set_hl(0, "Typedef", { fg = nord9_gui, ctermfg = nord9_term })


-- "+-----------+
-- "+ Languages +
-- "+-----------+
vim.api.nvim_set_hl(0, "asciidocAttributeEntry", { fg = nord10_gui, ctermfg = nord10_term })
vim.api.nvim_set_hl(0, "asciidocAttributeList", { fg = nord10_gui, ctermfg = nord10_term })
vim.api.nvim_set_hl(0, "asciidocAttributeRef", { fg = nord10_gui, ctermfg = nord10_term })
vim.api.nvim_set_hl(0, "asciidocHLabel", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "asciidocListingBlock", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "asciidocMacroAttributes", { fg = nord8_gui, ctermfg = nord8_term })
vim.api.nvim_set_hl(0, "asciidocOneLineTitle", { fg = nord8_gui, ctermfg = nord8_term })
vim.api.nvim_set_hl(0, "asciidocPassthroughBlock", { fg = nord9_gui, ctermfg = nord9_term })
vim.api.nvim_set_hl(0, "asciidocQuotedMonospaced", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "asciidocTriplePlusPassthrough", { fg = nord7_gui, ctermfg = nord7_term })
vim.cmd("hi! link asciidocAdmonition Keyword")
vim.cmd("hi! link asciidocAttributeRef markdownH1")
vim.cmd("hi! link asciidocBackslash Keyword")
vim.cmd("hi! link asciidocMacro Keyword")
vim.cmd("hi! link asciidocQuotedBold Bold")
vim.cmd("hi! link asciidocQuotedEmphasized Italic")
vim.cmd("hi! link asciidocQuotedMonospaced2 asciidocQuotedMonospaced")
vim.cmd("hi! link asciidocQuotedUnconstrainedBold asciidocQuotedBold")
vim.cmd("hi! link asciidocQuotedUnconstrainedEmphasized asciidocQuotedEmphasized")
vim.cmd("hi! link asciidocURL markdownLinkText")

vim.api.nvim_set_hl(0, "awkCharClass", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "awkPatterns", { fg = nord9_gui, ctermfg = nord9_term, bold = true, cterm = { bold = true } })
vim.cmd("hi! link awkArrayElement Identifier")
vim.cmd("hi! link awkBoolLogic Keyword")
vim.cmd("hi! link awkBrktRegExp SpecialChar")
vim.cmd("hi! link awkComma Delimiter")
vim.cmd("hi! link awkExpression Keyword")
vim.cmd("hi! link awkFieldVars Identifier")
vim.cmd("hi! link awkLineSkip Keyword")
vim.cmd("hi! link awkOperator Operator")
vim.cmd("hi! link awkRegExp SpecialChar")
vim.cmd("hi! link awkSearch Keyword")
vim.cmd("hi! link awkSemicolon Delimiter")
vim.cmd("hi! link awkSpecialCharacter SpecialChar")
vim.cmd("hi! link awkSpecialPrintf SpecialChar")
vim.cmd("hi! link awkVariables Identifier")

vim.api.nvim_set_hl(0, "cIncluded", { fg = nord7_gui, ctermfg = nord7_term })
vim.cmd("hi! link cOperator Operator")
vim.cmd("hi! link cPreCondit PreCondit")
vim.cmd("hi! link cConstant Type")

vim.api.nvim_set_hl(0, "cmakeGeneratorExpression", { fg = nord10_gui, ctermfg = nord10_term })

vim.cmd("hi! link csPreCondit PreCondit")
vim.cmd("hi! link csType Type")
vim.cmd("hi! link csXmlTag SpecialComment")

vim.api.nvim_set_hl(0, "cssAttributeSelector", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "cssDefinition", { fg = nord7_gui, ctermfg = nord7_term }) -- NONE
vim.api.nvim_set_hl(0, "cssIdentifier", { fg = nord7_gui, ctermfg = nord7_term, underline = true, cterm = { underline = true } })
vim.api.nvim_set_hl(0, "cssStringQ", { fg = nord7_gui, ctermfg = nord7_term, underline = true, cterm = { underline = true } })
vim.cmd("hi! link cssAttr Keyword")
vim.cmd("hi! link cssBraces Delimiter")
vim.cmd("hi! link cssClassName cssDefinition")
vim.cmd("hi! link cssColor Number")
vim.cmd("hi! link cssProp cssDefinition")
vim.cmd("hi! link cssPseudoClass cssDefinition")
vim.cmd("hi! link cssPseudoClassId cssPseudoClass")
vim.cmd("hi! link cssVendor Keyword")


vim.api.nvim_set_hl(0, "dosiniHeader", { fg = nord8_gui, ctermfg = nord8_term })
vim.cmd("hi! link dosiniLabel Type")

vim.api.nvim_set_hl(0, "dtBooleanKey", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "dtExecKey", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "dtLocaleKey", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "dtTypeKey", { fg = nord7_gui, ctermfg = nord7_term })
vim.cmd("hi! link dtDelim Delimiter")
vim.cmd("hi! link dtLocaleValue Keyword")
vim.cmd("hi! link dtTypeValue Keyword")


-- +- Git -+
-- Legacy groups for official git.vim and diff.vim syntax are the links
if uniform_diff_background then
    vim.api.nvim_set_hl(0, "DiffAdd", { fg = nord14_gui, bg = nord1_gui, ctermfg = nord14_term, ctermbg = nord1_term, link = "DiffAdded" })
    vim.api.nvim_set_hl(0, "DiffChange", { fg = nord13_gui, bg = nord1_gui, ctermfg = nord13_term, ctermbg = nord1_term, link = "DiffChanged" })
    vim.api.nvim_set_hl(0, "DiffDelete", { fg = nord11_gui, bg = nord1_gui, ctermfg = nord11_term, ctermbg = nord1_term, link = "DiffRemoved" })
    vim.api.nvim_set_hl(0, "DiffText", { fg = nord9_gui, bg = nord1_gui, ctermfg = nord9_term, ctermbg = nord1_term })
else
    vim.api.nvim_set_hl(0, "DiffAdd", { fg = nord14_gui, bg = nord0_gui, ctermfg = nord14_term, ctermbg = "NONE", reverse = true, cterm = { reverse = true }, link = "DiffAdded" })
    vim.api.nvim_set_hl(0, "DiffChange", { fg = nord13_gui, bg = nord0_gui, ctermfg = nord13_term, ctermbg = "NONE", reverse = true, cterm = { reverse = true }, link = "DiffChanged" })
    vim.api.nvim_set_hl(0, "DiffDelete", { fg = nord11_gui, bg = nord0_gui, ctermfg = nord11_term, ctermbg = "NONE", reverse = true, cterm = { reverse = true }, link = "DiffRemoved" })
    vim.api.nvim_set_hl(0, "DiffText", { fg = nord9_gui, bg = nord0_gui, ctermfg = nord9_term, ctermbg = "NONE", reverse = true, cterm = { reverse = true } })
end
vim.api.nvim_set_hl(0, "gitconfigVariable", { fg = nord7_gui, ctermfg = nord7_term })
-- END GIT

vim.api.nvim_set_hl(0, "goBuiltins", { fg = nord7_gui, ctermfg = nord7_term })
vim.cmd("hi! link goConstants Keyword")

vim.api.nvim_set_hl(0, "helpBar", { fg = nord3_gui, ctermfg = nord3_term })
vim.api.nvim_set_hl(0, "helpHyperTextJump", { fg = nord8_gui, ctermfg = nord8_term, underline = true, cterm = { underline = true } })

vim.api.nvim_set_hl(0, "htmlArg", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "htmlLink", { fg = nord4_gui, sp = "NONE" }) -- NONE
vim.cmd("hi! link htmlBold Bold")
vim.cmd("hi! link htmlEndTag htmlTag")
vim.cmd("hi! link htmlItalic Italic")
vim.cmd("hi! link htmlH1 markdownH1")
vim.cmd("hi! link htmlH2 markdownH1")
vim.cmd("hi! link htmlH3 markdownH1")
vim.cmd("hi! link htmlH4 markdownH1")
vim.cmd("hi! link htmlH5 markdownH1")
vim.cmd("hi! link htmlH6 markdownH1")
vim.cmd("hi! link htmlSpecialChar SpecialChar")
vim.cmd("hi! link htmlTag Keyword")
vim.cmd("hi! link htmlTagN htmlTag")

vim.api.nvim_set_hl(0, "javaDocTags", { fg = nord7_gui, ctermfg = nord7_term })
vim.cmd("hi! link javaCommentTitle Comment")
vim.cmd("hi! link javaScriptBraces Delimiter")
vim.cmd("hi! link javaScriptIdentifier Keyword")
vim.cmd("hi! link javaScriptNumber Number")

vim.api.nvim_set_hl(0, "jsonKeyword", { fg = nord7_gui, ctermfg = nord7_term })

vim.api.nvim_set_hl(0, "lessClass", { fg = nord7_gui, ctermfg = nord7_term })
vim.cmd("hi! link lessAmpersand Keyword")
vim.cmd("hi! link lessCssAttribute Delimiter")
vim.cmd("hi! link lessFunction Function")
vim.cmd("hi! link cssSelectorOp Keyword")

vim.cmd("hi! link lispAtomBarSymbol SpecialChar")
vim.cmd("hi! link lispAtomList SpecialChar")
vim.cmd("hi! link lispAtomMark Keyword")
vim.cmd("hi! link lispBarSymbol SpecialChar")
vim.cmd("hi! link lispFunc Function")

vim.cmd("hi! link luaFunc Function")

vim.api.nvim_set_hl(0, "markdownBlockquote", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "markdownCode", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "markdownCodeDelimiter", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "markdownFootnote", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "markdownId", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "markdownIdDeclaration", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "markdownH1", { fg = nord8_gui, ctermfg = nord8_term })
vim.api.nvim_set_hl(0, "markdownLinkText", { fg = nord8_gui, ctermfg = nord8_term })
vim.api.nvim_set_hl(0, "markdownUrl", { fg = nord4_gui, ctermfg = "NONE" }) -- NONE
vim.cmd("hi! link markdownBold Bold")
vim.cmd("hi! link markdownBoldDelimiter Keyword")
vim.cmd("hi! link markdownFootnoteDefinition markdownFootnote")
vim.cmd("hi! link markdownH2 markdownH1")
vim.cmd("hi! link markdownH3 markdownH1")
vim.cmd("hi! link markdownH4 markdownH1")
vim.cmd("hi! link markdownH5 markdownH1")
vim.cmd("hi! link markdownH6 markdownH1")
vim.cmd("hi! link markdownIdDelimiter Keyword")
vim.cmd("hi! link markdownItalic Italic")
vim.cmd("hi! link markdownItalicDelimiter Keyword")
vim.cmd("hi! link markdownLinkDelimiter Keyword")
vim.cmd("hi! link markdownLinkTextDelimiter Keyword")
vim.cmd("hi! link markdownListMarker Keyword")
vim.cmd("hi! link markdownRule Keyword")
vim.cmd("hi! link markdownHeadingDelimiter Keyword")

vim.api.nvim_set_hl(0, "perlPackageDecl", { fg = nord7_gui, ctermfg = nord7_term })

vim.api.nvim_set_hl(0, "phpClasses", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "phpDocTags", { fg = nord7_gui, ctermfg = nord7_term })
vim.cmd("hi! link phpDocCustomTags phpDocTags")
vim.cmd("hi! link phpMemberSelector Keyword")

vim.api.nvim_set_hl(0, "podCmdText", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "podVerbatimLine", { fg = nord4_gui, ctermfg = "NONE" })
vim.cmd("hi! link podFormat Keyword")

vim.cmd("hi! link pythonBuiltin Type")
vim.cmd("hi! link pythonEscape SpecialChar")

vim.api.nvim_set_hl(0, "rubyConstant", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "rubySymbol", { fg = nord6_gui, ctermfg = nord6_term, bold = true, cterm = { bold = true } })
vim.cmd("hi! link rubyAttribute Identifier")
vim.cmd("hi! link rubyBlockParameterList Operator")
vim.cmd("hi! link rubyInterpolationDelimiter Keyword")
vim.cmd("hi! link rubyKeywordAsMethod Function")
vim.cmd("hi! link rubyLocalVariableOrMethod Function")
vim.cmd("hi! link rubyPseudoVariable Keyword")
vim.cmd("hi! link rubyRegexp SpecialChar")

vim.api.nvim_set_hl(0, "rustAttribute", { fg = nord10_gui, ctermfg = nord10_term })
vim.api.nvim_set_hl(0, "rustEnum", { fg = nord7_gui, ctermfg = nord7_term, bold = true, cterm = { bold = true } })
vim.api.nvim_set_hl(0, "rustMacro", { fg = nord7_gui, ctermfg = nord7_term, bold = true, cterm = { bold = true } })
vim.api.nvim_set_hl(0, "rustModPath", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "rustPanic", { fg = nord9_gui, ctermfg = nord9_term, bold = true, cterm = { bold = true } })
vim.api.nvim_set_hl(0, "rustTrait", { fg = nord7_gui, ctermfg = nord7_term, italic = true, cterm = { italic = true } })
vim.cmd("hi! link rustCommentLineDoc Comment")
vim.cmd("hi! link rustDerive rustAttribute")
vim.cmd("hi! link rustEnumVariant rustEnum")
vim.cmd("hi! link rustEscape SpecialChar")
vim.cmd("hi! link rustQuestionMark Keyword")

vim.api.nvim_set_hl(0, "sassClass", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "sassId", { fg = nord7_gui, ctermfg = nord7_term, underline = true, cterm = { underline = true } })
vim.cmd("hi! link sassAmpersand Keyword")
vim.cmd("hi! link sassClassChar Delimiter")
vim.cmd("hi! link sassControl Keyword")
vim.cmd("hi! link sassControlLine Keyword")
vim.cmd("hi! link sassExtend Keyword")
vim.cmd("hi! link sassFor Keyword")
vim.cmd("hi! link sassFunctionDecl Keyword")
vim.cmd("hi! link sassFunctionName Function")
vim.cmd("hi! link sassidChar sassId")
vim.cmd("hi! link sassInclude SpecialChar")
vim.cmd("hi! link sassMixinName Function")
vim.cmd("hi! link sassMixing SpecialChar")
vim.cmd("hi! link sassReturn Keyword")

vim.cmd("hi! link shCmdParenRegion Delimiter")
vim.cmd("hi! link shCmdSubRegion Delimiter")
vim.cmd("hi! link shDerefSimple Identifier")
vim.cmd("hi! link shDerefVar Identifier")

vim.cmd("hi! link sqlKeyword Keyword")
vim.cmd("hi! link sqlSpecial Keyword")

vim.api.nvim_set_hl(0, "vimAugroup", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "vimMapRhs", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "vimNotation", { fg = nord7_gui, ctermfg = nord7_term })
vim.cmd("hi! link vimFunc Function")
vim.cmd("hi! link vimFunction Function")
vim.cmd("hi! link vimUserFunc Function")

vim.api.nvim_set_hl(0, "xmlAttrib", { fg = nord7_gui, ctermfg = nord7_term })
vim.api.nvim_set_hl(0, "xmlCdataStart", { fg = nord3_gui_bright, ctermfg = nord3_term, bold = true, cterm = { bold = true } })
vim.api.nvim_set_hl(0, "xmlNamespace", { fg = nord7_gui, ctermfg = nord7_term })
vim.cmd("hi! link xmlAttribPunct Delimiter")
vim.cmd("hi! link xmlCdata Comment")
vim.cmd("hi! link xmlCdataCdata xmlCdataStart")
vim.cmd("hi! link xmlCdataEnd xmlCdataStart")
vim.cmd("hi! link xmlEndTag xmlTagName")
vim.cmd("hi! link xmlProcessingDelim Keyword")
vim.cmd("hi! link xmlTagName Keyword")

vim.api.nvim_set_hl(0, "yamlBlockMappingKey", { fg = nord7_gui, ctermfg = nord7_term })
vim.cmd("hi! link yamlBool Keyword")
vim.cmd("hi! link yamlDocumentStart Keyword")

-- "+----------------+
-- "+ Plugin Support +
-- "+----------------+
-- " fugitive.vim
-- " > tpope/vim-fugitive
vim.api.nvim_set_hl(0, "gitcommitDiscardedFile", { fg = nord11_gui, ctermfg = nord11_term })
vim.api.nvim_set_hl(0, "gitcommitUntrackedFile", { fg = nord11_gui, ctermfg = nord11_term })
vim.api.nvim_set_hl(0, "gitcommitSelectedFile", { fg = nord14_gui, ctermfg = nord14_term })

-- " vim-plug
-- " > junegunn/vim-plug
vim.api.nvim_set_hl(0, "plugDeleted", { fg = nord11_gui, ctermbg = nord11_term })

-- " tree-sitter
-- " > nvim-treesitter/nvim-treesitter
vim.cmd("hi! link TSAnnotation Annotation")
vim.cmd("hi! link TSConstBuiltin Constant")
vim.cmd("hi! link TSConstructor Function")
vim.cmd("hi! link TSEmphasis Italic")
vim.cmd("hi! link TSFuncBuiltin Function")
vim.cmd("hi! link TSFuncMacro Function")
vim.cmd("hi! link TSStringRegex SpecialChar")
vim.cmd("hi! link TSStrong Bold")
vim.cmd("hi! link TSStructure Structure")
vim.cmd("hi! link TSTagDelimiter TSTag")
vim.cmd("hi! link TSUnderline Underline")
vim.cmd("hi! link TSVariable Variable")
vim.cmd("hi! link TSVariableBuiltin Keyword")

-- " TypeScript JSX
vim.api.nvim_set_hl(0, "tsxAttrib", { fg = nord7_gui, ctermfg = nord7_term })
vim.cmd("hi! link typescriptOperator Operator")
vim.cmd("hi! link typescriptBinaryOp Operator")
vim.cmd("hi! link typescriptAssign Operator")
vim.cmd("hi! link typescriptMember Identifier")
vim.cmd("hi! link typescriptDOMStorageMethod Identifier")
vim.cmd("hi! link typescriptArrowFuncArg Identifier")
vim.cmd("hi! link typescriptGlobal typescriptClassName")
vim.cmd("hi! link typescriptBOMWindowProp Function")
vim.cmd("hi! link typescriptArrowFuncDef Function")
vim.cmd("hi! link typescriptAliasDeclaration Function")
vim.cmd("hi! link typescriptPredefinedType Type")
vim.cmd("hi! link typescriptTypeReference typescriptClassName")
vim.cmd("hi! link typescriptTypeAnnotation Structure")
vim.cmd("hi! link typescriptDocNamedParamType SpecialComment")
vim.cmd("hi! link typescriptDocNotation Keyword")
vim.cmd("hi! link typescriptDocTags Keyword")
vim.cmd("hi! link typescriptImport Keyword")
vim.cmd("hi! link typescriptExport Keyword")
vim.cmd("hi! link typescriptTry Keyword")
vim.cmd("hi! link typescriptVariable Keyword")
vim.cmd("hi! link typescriptBraces Normal")
vim.cmd("hi! link typescriptObjectLabel Normal")
vim.cmd("hi! link typescriptCall Normal")
vim.cmd("hi! link typescriptClassHeritage typescriptClassName")
vim.cmd("hi! link typescriptFuncTypeArrow Structure")
vim.cmd("hi! link typescriptMemberOptionality Structure")
vim.cmd("hi! link typescriptNodeGlobal typescriptGlobal")
vim.cmd("hi! link typescriptTypeBrackets Structure")
vim.cmd("hi! link tsxEqual Operator")
vim.cmd("hi! link tsxIntrinsicTagName htmlTag")
vim.cmd("hi! link tsxTagName tsxIntrinsicTagName")

-- Setup function
local M = {}

function M.setup() end
