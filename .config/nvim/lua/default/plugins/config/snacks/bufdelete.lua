--[[[
-- Delete buffers without disrupting window layout.
--
-- :h snacks-bufdelete
--]]

return {
	"snacks.nvim",
	keys = {
		{
			"<leader>bd",
			function()
				Snacks.bufdelete.delete()
			end,
			desc = "[B]uffer [D]elete",
		},
	},
}
