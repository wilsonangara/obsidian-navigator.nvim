local config = require("obsidian-navigator.config")
local utils = require("obsidian-navigator.utils")
local commands = require("obsidian-navigator.commands")
local handlers = require("obsidian-navigator.handlers")

local M = {}

vim.api.nvim_create_augroup("obsidian-navigator.nvim", { clear = true })

-- Initialize the plugin configuration.
local function init()
	-- Checks whether the current working directory, if no, turn off the plugin.
	if not utils.is_inside_vault() then
		config.on = false
		return
	end

	-- Register commands to Neovim
	commands.register()

	handlers.on_buf_enter()
end

function M.setup(user_config)
	config.setup_config(user_config)

	vim.api.nvim_create_autocmd("BufEnter", {
		callback = init,
		pattern = "*",
		group = "obsidian-navigator.nvim",
	})

	-- Creates a single timer specific for debouncing the scroll into view
	local debounce_scroll = utils.debounce(handlers.scroll_into_view, 400)
	vim.api.nvim_create_autocmd("CursorMoved", {
		callback = function()
			local line = vim.api.nvim_win_get_cursor(0)[1]
			debounce_scroll(line)
		end,
		pattern = "*.md",
		group = "obsidian-navigator.nvim",
	})
end

return M
