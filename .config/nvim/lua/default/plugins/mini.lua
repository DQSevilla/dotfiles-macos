return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup({})
		vim.keymap.set({ "n", "x" }, "s", "<Nop>")

		require("mini.icons").setup({})
		MiniIcons.mock_nvim_web_devicons()
	end,
}
