return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		keymap = { preset = "default" },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
}
