--[[
-- Various plugins bundled together.
--
-- https://github.com/folke/snacks.nvim
--]]
return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	---@type snacks.Config
	opts = {
		-- Turn off treesitter and LSP for big files
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		dim = { enabled = true },
		explorer = { enabled = true },
		gitbrowse = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}
