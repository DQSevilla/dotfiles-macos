--[[
-- Picker for fuzzy-finding almost anything.
--
-- :h snacks-picker
--]]

return {
	"snacks.nvim",
	opts = {
		picker = {},
		explorer = {},
	},
	keys = {
		-- Top Pickers
		{
			"<leader><leader>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "View Buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep Search",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "[N]otification History",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File [E]xplorer",
		},
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
		-- Grep
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "[S]earch Open [B]uffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "[S]earch by [G]rep",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "[S]earch Visual [S]election",
			mode = { "n", "x" },
		},
		-- Search
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "[S]earch Registers",
		},
		{
			"<leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "[S]earch History",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "[S]earch [A]utocmds",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "[S]earch [C]ommand History",
		},
		{
			"<leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "[S]earch Available [C]ommands",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[S]earch [D]iagnostics",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "[S]earch Buffer [D]iagnostics",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "[S]earch [H]elp",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "[S]earch [H]ighlights",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "[S]earch [I]cons",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "[S]earch [J]umps",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "[S]earch [K]eymaps",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "[S]earch [L]ocation List",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "[S]earch [M]arks",
		},
		{
			"<leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "[S]earch [M]an Pages",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.lazy()
			end,
			desc = "[S]earch [P]lugin Specs",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "[S]earch [Q]uickfix",
		},
		{
			"<leader>sR",
			function()
				Snacks.picker.resume()
			end,
			desc = "[S]earch [R]esume",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "[S]earch [U]ndo History",
		},
		{
			"<leader>uC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
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
