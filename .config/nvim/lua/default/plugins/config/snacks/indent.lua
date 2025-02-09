--[[
-- Visualize indent guides and scopes based on treesitter or indent.
--
-- :h snacks-indent
--]]

return {
	"snacks.nvim",
	opts = {
		indent = {
			indent = {
				char = "▏",
			},
			scope = {
				char = "▏",
				only_current = true,
			},
		},
	},
}
