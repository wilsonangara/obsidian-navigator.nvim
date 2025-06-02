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
end

return M
