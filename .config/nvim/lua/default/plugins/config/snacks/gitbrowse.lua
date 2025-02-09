--[[
-- Open current file in the remote repository in the browser.
--
-- :h snacks-gitbrowse
--]]

return {
	"snacks.nvim",
	what = "file",
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
