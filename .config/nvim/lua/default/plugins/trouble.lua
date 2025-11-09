--[[
-- Better Diagnostic Messages
--
-- https://github.com/folke/trouble.nvim
--]]

return {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
	keys = {
		{
			"<leader>tt",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "[T]rouble [T]oggle",
		},
		{
			"<leader>tT",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "[T]rouble [T]oggle Current Buffer",
		},
		{
			"<leader>ts",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "[T]rouble [S]ymbols Toggle",
		},
		{
			"<leader>tl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "[T]rouble [L]SP Toggle",
		},
		{
			"<leader>tL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "[T]rouble [L]oclist Toggle",
		},
		{
			"<leader>tQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "[T]rouble [Q]uickfix List Toggle",
		},
	},
}
