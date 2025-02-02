--[[
-- Basic Keymaps
--
-- More key bindings may be setup in plugin config
--]]

local map = vim.keymap.set

-- Clear search highlight when pressing <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Execute lua code and source config
map("n", "<leader>X", "<cmd>source %<CR>", { desc = "Source file in buffer" })
map("n", "<leader>x", ":.lua<CR>", { desc = "E[x]ecute Lua code" })
map("v", "<leader>x", ":lua<CR>", { desc = "E[x]ecute Lua code" })
