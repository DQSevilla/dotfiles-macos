--[[
-- Picker for fuzzy-finding almost anything.
--
-- :h snacks-picker
--]]

return {
	"snacks.nvim",
	opts = {
		picker = {},
	},
	keys = {
		-- [F]ind Things
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "[F]ind [B]uffers",
		},
		{
			"<leader>fc",
			function()
				local path = vim.fn.stdpath("config")
				path = (type(path) == "string" and path) or "~/.config/nvim"
				Snacks.picker.files({ cwd = path })
			end,
			desc = "[F]ind Nvim [C]onfig",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "[F]ind [F]iles",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "[F]ind [G]it Files",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
			desc = "[F]ind [P]rojects",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "[F]ind [R]ecent",
		},

		-- [G]it
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "[G]it [B]ranches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		-- TODO: What is this for and why doesn't it work
		-- NOTE: Conflicting keymap, see default.plugins.config.snacks.git
		-- {
		-- 	"<leader>gL",
		-- 	function()
		-- 		Snacks.picker.git_log_line()
		-- 	end,
		-- 	desc = "Git Log Line",
		-- },
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
	},
}
