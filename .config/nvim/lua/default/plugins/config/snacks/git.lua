--[[
-- Git utilities.
--
-- :h snacks-git
--]]

return {
	"snacks.nvim",
	keys = {
		{
			"<leader>gl",
			function()
				Snacks.git.blame_line()
			end,
			desc = "[G]it [L]og",
		},
	},
}
