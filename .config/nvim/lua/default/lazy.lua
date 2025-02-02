--[[
-- Install lazy.nvim for plugin loading
--
-- Code borrowed from https://lazy.folke.io/installation
--]]

-- Bootstrap lazy.nvim
local lazy_path = vim.fn.stdpath("data") .. "lazy/lazy.nivm"
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
	local lazy_repo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable", -- latest stable release
		lazy_repo,
		lazy_path,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

-- Add lazy to `runtimepath` so we can `require` it
vim.opt.rtp:prepend(lazy_path)

-- Setup lazy and load plugins
require("lazy").setup({
	spec = {
		{ import = "default/plugins" },
	},
	change_detection = { notify = false },
})
