--[[
-- Configuration for LSP and other code intelligence plugins.
--]]

-- Extend LSP Client capabilities with functionality from plugins
local capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "cmp_nvim_lsp") then
	-- stylua: ignore
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		capabilities,
		require("cmp_nvim_lsp").default_capabilities()
	)
end

-- Language servers and their settings
local servers = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				completion = { callSnippet = "Replace" },
			},
		},
	},
	pyright = {},
	bashls = {},
	gopls = {
		settings = {
			gopls = {
				gofumpt = true,
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	},
}

-- Language formatters
local formatters_by_ft = {
	lua = { "stylua" },
	go = { "gofumpt", "goimports", "goimports-reviser" },
	python = { "isort", "black" },
	bash = { "shellcheck", "shfmt" },
}

-- Ensuring servers and tools are installed. See :Mason
require("mason").setup()

local ensure_installed = {}
for _, tools in pairs(formatters_by_ft) do
	for _, tool in ipairs(tools) do
		if vim.fn.executable(tool) == 0 then
			table.insert(ensure_installed, tool)
		end
	end
end

vim.list_extend(ensure_installed, vim.tbl_keys(servers or {}))
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}

			-- Server-specific overrides to LSP capabilities
			-- stylua: ignore
			server.capabilities = vim.tbl_deep_extend(
				"force",
				{},
				capabilities,
				server.capabilities or {}
			)
			require("lspconfig")[server_name].setup(server)
		end,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		-- TODO: more mappings
		local mappings = {
			{
				keys = "gd",
				picker_func = function()
					Snacks.picker.lsp_definitions()
				end,
				fallback_func = vim.lsp.buf.definition,
				desc = "[G]oto [D]efinition",
			},
			{
				keys = "gD",
				picker_func = function()
					Snacks.picker.lsp_declarations()
				end,
				fallback_func = vim.lsp.buf.declaration,
				desc = "[G]oto [D]eclaration",
			},
			{
				keys = "gr",
				picker_func = function()
					Snacks.picker.lsp_references()
				end,
				fallback_func = vim.lsp.buf.references,
				desc = "[G]oto [R]eferences",
			},
			{
				-- useful for languages that declare types without implementations
				keys = "gI",
				picker_func = function()
					Snacks.picker.lsp_implementations()
				end,
				fallback_func = vim.lsp.buf.implementation,
				desc = "[G]oto [I]mplementation",
			},
			{
				keys = "gt",
				picker_func = function()
					Snacks.picker.lsp_type_definitions()
				end,
				fallback_func = vim.lsp.buf.type_definition(),
				desc = "[G]oto [T]ype Definitions",
			},
			-- TODO: trouble.nvim?
			-- FIXME: I feel like the following should be default behavior...
			{
				keys = "]d",
				fallback_func = function() -- TODO: same but for [d?
					vim.diagnostic.goto_next()
					vim.diagnostic.open_float()
				end,
				desc = "Jump to next [d]iagnostic",
			},
			{
				keys = "[d",
				fallback_func = function()
					vim.diagnostic.goto_prev()
					vim.diagnostic.open_float()
				end,
				desc = "Jump to previous [d]iagnostic",
			},
			{
				-- fuzzy find all symbols in current document
				keys = "<leader>ds",
				picker_func = function()
					Snacks.picker.lsp_symbols()
				end,
				fallback_func = vim.lsp.buf.document_symbol,
				desc = "[D]ocument [S]earch",
			},
			{
				-- fuzzy find all symbols in current workspace
				keys = "<leader>ws",
				picker_func = function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				fallback_func = vim.lsp.buf.workspace_symbol,
				desc = "[W]orkspace [S]earch",
			},
			{
				-- rename accross files
				keys = "<leader>rn",
				fallback_func = vim.lsp.buf.rename,
				desc = "[R]e[n]ame",
			},
			{
				-- execute a code action
				keys = "<leader>ca",
				fallback_func = vim.lsp.buf.code_action,
				desc = "[C]ode [A]ction",
			},
			{
				keys = "K",
				fallback_func = vim.lsp.buf.hover,
				desc = "Hover Documentation",
			},
		}

		-- buffer-specific keymap for when LSP attached
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Map to the better snacks.picker equivalents when possible:
		local have_snacks_picker = pcall(require, "snacks.picker")
		for _, m in ipairs(mappings) do
			local f = (have_snacks_picker and m.picker_func) or m.fallback_func

			map(m.keys, f, m.desc)
		end

		local client = assert(vim.lsp.get_client_by_id(event.data.client_id), "must have valid LSP client")

		-- Highlight references of word under cursor, and clear them when moving the cursor:
		if client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

if pcall(require, "conform") then
	require("conform").setup({
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- disable format_on_save lsp_fallback for languages without
			-- a standard coding style:
			local disable_filetypes = { c = true, cpp = true }
			return {
				bufnr = bufnr,
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = formatters_by_ft,
	})
end

--[[ Notifications for LSP Progress ]]

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()

vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
		if not client or type(value) ~= "table" then
			return
		end
		local p = progress[client.id]

		for i = 1, #p + 1 do
			if i == #p + 1 or p[i].token == ev.data.params.token then
				p[i] = {
					token = ev.data.params.token,
					msg = ("[%3d%%] %s%s"):format(
						value.kind == "end" and 100 or value.percentage or 100,
						value.title or "",
						value.message and (" **%s**"):format(value.message) or ""
					),
					done = value.kind == "end",
				}
				break
			end
		end

		local msg = {} ---@type string[]
		progress[client.id] = vim.tbl_filter(function(v)
			return table.insert(msg, v.msg) or not v.done
		end, p)

		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
			id = "lsp_progress",
			title = client.name,
			opts = function(notif)
				notif.icon = #progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})
