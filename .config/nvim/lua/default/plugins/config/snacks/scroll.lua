--[[
-- Smooth scrolling for Neovim. Properly handles scrolloff and mouse scrolling.
--
-- :h snacks-scroll
--]]

return {
	"snacks.nvim",
	opts = {
		scroll = {
			duration = { step = 10, total = 100 },
		},
	},
}
