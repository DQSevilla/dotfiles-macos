-- Setup advanced LSP capabilities
local capabilities = (function()
	if pcall(require, "blink.cmp") then
		return require("blink.cmp").get_lsp_capabilities()
	end
	return vim.lsp.protocol.make_client_capabilities()
end)()

-- Set capabilities for all servers
vim.lsp.config("*", {
	capabilities = capabilities,
})

-- Language servers and their settings
local servers = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					-- vim global vars/tables known to LSP
					globals = { "vim" },
				},
				completion = { callSnippet = "Replace" },
			},
		},
	},
}

require("mason").setup()

-- Only install a server via Mason if not in the PATH
local mason_installed_servers = {}
for server, _ in pairs(servers) do
	if vim.fn.executable(server) == 0 then
		table.insert(mason_installed_servers, server)
	end
end

require("mason-lspconfig").setup({
	ensure_installed = mason_installed_servers,
})

-- Enable and apply config for each server
for server, custom_conf in pairs(servers) do
	vim.lsp.config(server, custom_conf or {})
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
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
				fallback_func = vim.lsp.buf.type_definition,
				desc = "[G]oto [T]ype Definitions",
			},
			-- {
			-- 	keys = "]d",
			-- 	fallback_func = function()
			-- 		vim.diagnostic.goto_next()
			-- 		vim.diagnostic.open_float()
			-- 	end,
			-- 	desc = "Jump to next [d]iagnostic",
			-- },
			-- {
			-- 	keys = "[d",
			-- 	fallback_func = function()
			-- 		vim.diagnostic.goto_prev()
			-- 		vim.diagnostic.open_float()
			-- 	end,
			-- 	desc = "Jump to previous [d]iagnostic",
			-- },
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

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local have_snacks_picker = pcall(require, "snacks.picker")
		for _, m in ipairs(mappings) do
			local f = (have_snacks_picker and m.picker_func) or m.fallback_func
			map(m.keys, f, m.desc)
		end

		local client = assert(vim.lsp.get_client_by_id(event.data.client_id), "must have valid LSP client")

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
