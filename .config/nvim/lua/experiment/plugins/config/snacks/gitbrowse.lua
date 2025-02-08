--[[
-- Configure gitbrowse for snacks.nvim
--]]

return {
	"snacks.nvim",
	keys = {
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "[G]it [B]rowse",
		},
	},
}
