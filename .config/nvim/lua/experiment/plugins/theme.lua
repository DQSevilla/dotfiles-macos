--[[
-- Plugins related to theming.
--
-- https://github.com/folke/tokyonight.nvim
--]]

--[[
-- folke/todo-comments:
-- TODO:
-- NOTE:
-- INFO:
-- PERF:
-- PERFORMANCE:
-- OPTIM:
-- OPTIMIZE:
-- TEST:
-- TESTING:
-- PASSED:
-- FAILED:
-- XXX:
-- HACK:
-- WARN:
-- WARNING:
-- BUG:
-- FIX:
-- FIXME:
-- FIXIT:
-- ISSUE:
]]

-- I like using the math/PL symbols for "top type" and "bottom type" for file progress
local function progress_fmt(progress)
	if progress == "Top" then
		return "⟙"
	end
	if progress == "Bot" then
		return "⟘"
	end
	return progress
end

-- TODO: color picker to sync wezterm, neovim, and bat themes.
---- Needs to be able to switch from light to dark too
---- Maybe even loading a custom theme built on tokyonight...
return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("tokyonight")
			vim.cmd.hi("Comment gui=none")
		end,
		opts = { style = "moon" },
	},
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 		vim.cmd.hi("Comment gui=none")
	-- 	end,
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "moon",
	-- 			light_style = "day",
	-- 			transparent = false,
	-- 			terminal_colors = true,
	-- 			styles = {
	-- 				keywords = { italic = false },
	-- 			},
	-- 			day_brightness = 0.3,
	-- 			dim_inactive = true,
	-- 			lualine_bold = false,
	-- 			-- Required fields. TODO: should I do something special with them?
	-- 			on_colors = function(_) end,
	-- 			on_highlights = function(_, _) end,
	-- 			cache = true,
	-- 			plugins = {
	-- 				-- let lazy.nvim automatically enable needed plugins
	-- 				auto = true,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		-- TODO: Add keybinds for telescope search of todos and quickfix/trouble
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = {
			-- Required utilities
			"nvim-lua/plenary.nvim",
		},
		opts = {
			signs = false,
			highlight = {
				pattern = {
					-- e.g. TODO(JIRA-NUMBER):
					[=[.*<((KEYWORDS)%(\(.{-1,}\))?):]=],
					-- e.g. BUG 1:
					[=[.*<((KEYWORDS)%(\s+\d+)?):]=],
				},
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		config = function()
			require("lualine").setup({
				-- Sections are |a|b|c ... x|y|z|
				sections = {
					lualine_y = {
						{ "progress", fmt = progress_fmt },
					},
				},
				inactive_sections = {
					lualine_x = {
						{ "progress", fmt = progress_fmt },
						"location",
					},
				},
			})
		end,
	},
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	opts = { indent = { char = progressive } },
	-- },
}
