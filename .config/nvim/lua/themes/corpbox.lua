-- lua/themes/corpbox.lua

local M = {}

-- Set the colorscheme name for vim.g.colors_name
vim.g.colors_name = "corpbox"

-- Color Palette inspired by usgraphics.com aesthetics
-- Clean, professional, with a warm off-white base.
local p = {
	bg = "#fdfcfb", -- Main background (Warm Ivory)
	bg_alt = "#f5f2ef", -- Alternate BG for floats, sidebars (Slightly darker)
	bg_visual = "#e0e8f0", -- BG for visual selection (Subtle Blue)
	bg_status = "#e9e6e3", -- BG for statusline (Slightly darker neutral)

	fg = "#3d424d", -- Main foreground (Dark Charcoal)
	fg_alt = "#7a8290", -- Lighter foreground for comments, line numbers
	fg_dark = "#2a2e36", -- Darker foreground for statusline text

	border = "#d4d1cc", -- Border color for floats

	red = "#d73737", -- A clear, strong red for errors and diffs
	orange = "#e67e00", -- A corporate orange for numbers and warnings
	green = "#008a00", -- A standard green for strings
	cyan = "#008b8b", -- A strong teal/cyan for includes and constants
	blue = "#005faf", -- A corporate blue for functions and statements
	purple = "#8f4f9f", -- A muted purple for types and keywords
}

-- Define the highlight groups
-- The core of the colorscheme
local highlights = {
	-- Editor Basics
	Normal = { fg = p.fg, bg = p.bg },
	NormalNC = { fg = p.fg, bg = p.bg }, -- Non-current windows
	SignColumn = { bg = p.bg },
	MsgArea = { fg = p.fg, bg = p.bg_alt },
	ModeMsg = { fg = p.fg, gui = "bold" },
	Visual = { bg = p.bg_visual },
	CursorLine = { bg = p.bg_alt },
	CursorLineNr = { fg = p.blue, bg = p.bg_alt, gui = "bold" },
	LineNr = { fg = p.fg_alt, bg = p.bg },
	ColorColumn = { bg = p.bg_alt },
	Conceal = { fg = p.fg_alt, bg = p.bg },
	Search = { fg = p.fg_dark, bg = p.orange, gui = "NONE" },
	IncSearch = { fg = p.fg_dark, bg = p.blue, gui = "NONE" },

	-- UI Elements (The "Boxy" Part)
	StatusLine = { fg = p.fg_dark, bg = p.bg_status, gui = "NONE" },
	StatusLineNC = { fg = p.fg_alt, bg = p.bg_alt, gui = "NONE" },
	TabLine = { fg = p.fg_alt, bg = p.bg_alt },
	TabLineFill = { bg = p.bg_alt },
	TabLineSel = { fg = p.fg_dark, bg = p.bg_status, gui = "bold" },
	NormalFloat = { fg = p.fg, bg = p.bg_alt },
	FloatBorder = { fg = p.blue, bg = p.bg_alt },
	Pmenu = { fg = p.fg, bg = p.bg_alt },
	PmenuSel = { fg = p.fg_dark, bg = p.bg_visual },
	PmenuSbar = { bg = p.bg_alt },
	PmenuThumb = { bg = p.fg_alt },

	-- Syntax Highlighting
	Comment = { fg = p.fg_alt, gui = "italic" },
	Constant = { fg = p.cyan },
	String = { fg = p.green },
	Character = { fg = p.green },
	Number = { fg = p.orange },
	Boolean = { fg = p.orange, gui = "bold" },
	Float = { fg = p.orange },
	Identifier = { fg = p.blue, gui = "NONE" },
	Function = { fg = p.blue, gui = "NONE" },
	Statement = { fg = p.purple, gui = "bold" },
	Conditional = { fg = p.purple, gui = "bold" },
	Repeat = { fg = p.purple, gui = "bold" },
	Label = { fg = p.purple, gui = "bold" },
	Operator = { fg = p.fg },
	Keyword = { fg = p.purple },
	Exception = { fg = p.purple, gui = "bold" },
	PreProc = { fg = p.cyan },
	Include = { fg = p.cyan },
	Define = { fg = p.cyan },
	Type = { fg = p.purple },
	StorageClass = { fg = p.purple },
	Structure = { fg = p.purple },
	Typedef = { fg = p.purple, gui = "bold" },
	Special = { fg = p.fg },
	Underlined = { gui = "underline" },
	Title = { fg = p.blue, gui = "bold" },
	Todo = { fg = p.fg_dark, bg = p.orange, gui = "bold" },
	Error = { fg = p.red, bg = p.bg_alt, gui = "bold" },
	ErrorMsg = { fg = p.red, bg = p.bg },

	-- Diffs
	DiffAdd = { bg = "#e1f0e1" }, -- Soft green background
	DiffChange = { bg = "#e0e8f0" }, -- Soft blue background
	DiffDelete = { bg = "#f5e1e1" }, -- Soft red background
	DiffText = { bg = "#dce4ec", gui = "bold" },

	-- LSP Diagnostics
	DiagnosticError = { fg = p.red },
	DiagnosticWarn = { fg = p.orange },
	DiagnosticInfo = { fg = p.blue },
	DiagnosticHint = { fg = p.cyan },
	DiagnosticUnderlineError = { gui = "undercurl", sp = p.red },
	DiagnosticUnderlineWarn = { gui = "undercurl", sp = p.orange },
	DiagnosticUnderlineInfo = { gui = "undercurl", sp = p.blue },
	DiagnosticUnderlineHint = { gui = "undercurl", sp = p.cyan },

	-- TreeSitter (falls back to above if not available)
	["@variable"] = { fg = p.fg },
	["@function"] = { fg = p.blue },
	["@function.call"] = { fg = p.blue },
	["@keyword"] = { fg = p.purple },
	["@keyword.function"] = { fg = p.purple, gui = "bold" },
	["@method"] = { fg = p.blue },
	["@parameter"] = { fg = p.fg, gui = "italic" },
	["@property"] = { fg = p.cyan },
	["@constructor"] = { fg = p.purple },
	["@string"] = { fg = p.green },
	["@string.escape"] = { fg = p.cyan },
	["@character"] = { fg = p.green },
	["@number"] = { fg = p.orange },
	["@boolean"] = { fg = p.orange, gui = "bold" },
	["@float"] = { fg = p.orange },
	["@type"] = { fg = p.purple },
	["@type.builtin"] = { fg = p.purple, gui = "bold" },
	["@namespace"] = { fg = p.fg },
	["@operator"] = { fg = p.fg },
	["@punctuation.bracket"] = { fg = p.fg },
	["@punctuation.delimiter"] = { fg = p.fg },
	["@comment"] = { fg = p.fg_alt, gui = "italic" },
	["@constant"] = { fg = p.cyan },
	["@constant.builtin"] = { fg = p.cyan, gui = "bold" },
	["@include"] = { fg = p.cyan },
	["@tag"] = { fg = p.blue },
	["@tag.attribute"] = { fg = p.orange },
	["@tag.delimiter"] = { fg = p.fg_alt },
	["@text.title"] = { fg = p.blue, gui = "bold" },
	["@text.uri"] = { fg = p.green, gui = "underline" },
}

-- Main function to apply the theme
function M.load()
	-- Clear all existing highlights
	vim.cmd("hi clear")

	-- Set terminal colors (optional, but good for consistency)
	if vim.fn.has("nvim-0.8") == 1 then
		vim.g.terminal_color_0 = p.bg_status
		vim.g.terminal_color_1 = p.red
		vim.g.terminal_color_2 = p.green
		vim.g.terminal_color_3 = p.orange
		vim.g.terminal_color_4 = p.blue
		vim.g.terminal_color_5 = p.purple
		vim.g.terminal_color_6 = p.cyan
		vim.g.terminal_color_7 = p.fg
		vim.g.terminal_color_8 = p.fg_alt
		vim.g.terminal_color_9 = p.red
		vim.g.terminal_color_10 = p.green
		vim.g.terminal_color_11 = p.orange
		vim.g.terminal_color_12 = p.blue
		vim.g.terminal_color_13 = p.purple
		vim.g.terminal_color_14 = p.cyan
		vim.g.terminal_color_15 = p.fg_dark
	end

	-- Set background to light
	vim.o.background = "light"

	-- Apply all the highlight groups
	for group, s in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, s)
	end
end

return M
