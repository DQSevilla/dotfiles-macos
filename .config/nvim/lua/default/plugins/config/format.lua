-- Language formatters
local formatters_by_ft = {
	lua = { "stylua" },
	go = { "gofumpt", "goimports", "goimports-reviser" },
	python = { "isort", "black" },
	bash = { "shellcheck", "shfmt" },
	scala = { "scalafmt" },
}

-- Only install a tool via Mason if not in the PATH
local mason_installed_tools = {}
for _, tools in pairs(formatters_by_ft) do
	for _, tool in ipairs(tools) do
		if vim.fn.executable(tool) == 0 then
			table.insert(mason_installed_tools, tool)
		end
	end
end

require("mason-tool-installer").setup({
	ensure_installed = mason_installed_tools,
})

if pcall(require, "conform") then
	require("conform").setup({
		notify_on_error = false,
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true, scala = true }
			return {
				bufnr = bufnr,
				timeout_ms = 1000,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = formatters_by_ft,
	})

	vim.g.conform_log_level = "debug"
	vim.g.conform_log = true
end
