--[[
-- https://github.com/nvim-treesitter/nvim-treesitter
--
-- Treesitter for better highlighting and advanced AST queries
--]]

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"go",
				"gitcommit",
				"gitignore",
				"gomod",
				"gosum",
				"gotmpl",
				"gowork",
				"json",
				"jq",
				"lua",
				"luadoc",
				"make",
				"markdown",
				"markdown_inline",
				"ocaml",
				"python",
			},

			-- auto_install = true,
			highlight = {
				enable = true,
				disable = function(_, buf)
					local max_filesize = 100 * 1024 -- 100KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					return ok and stats and stats.size > max_filesize
				end,
			},
			indent = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			-- TODO: explore additional modules
		end,
	},
}
