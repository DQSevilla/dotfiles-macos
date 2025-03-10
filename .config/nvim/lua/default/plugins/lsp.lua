--[[
-- https://github.com/neovim/nvim-lspconfig
--
-- Configs for the nvim LSP client.
--]]

-- TODO: look into a more modular solution or combining all tools that require external deps here
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install and manage external editor tools
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Autoformatting
			"stevearc/conform.nvim",

			-- Lua LSP for Wezterm config types
			{ "justinsgithub/wezterm-types", lazy = true },

			-- Lua LSP for neovim config, runtime, API, plugins, ...
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },

						-- Load the wezterm types when the `wezterm` module is required
						{ path = "wezterm-types", mods = { "wezterm" } },

						-- snacks required everywhere as Snacks
						{ path = "snacks.nvim", words = { "Snacks" } },
					},
				},
			},
		},
		config = function()
			require("default.plugins.config.lsp")
		end,
	},
}
