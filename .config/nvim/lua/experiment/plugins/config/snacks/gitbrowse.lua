--[[
-- Configure gitbrowse for snacks.nvim
--]]

return {
	"snacks.nvim",
	keys = {
		{
			"<leader>gb",
			function()
				Snacks.gitbrowse()
			end,
			desc = "[G]it [B]rowse",
		},
	},
}
