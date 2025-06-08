local config = require("obsidian-navigator.config")
local utils = require("obsidian-navigator.utils")
local handlers = require("obsidian-navigator.handlers")

local M = {}

-- Function to enable the plugin, although there are some pre-requisites:
--  - Buffer in the current working directory should be inside one of the
--    vaults registered.
function On()
	-- Return early when the plugin is already enabled
	if config.on then
		return
	end

	-- Check if the current working directory is inside a vault
	if not utils.is_inside_vault() then
		vim.api.nvim_err_writeln("Obsidian Navigator: Not inside a vault.")
		return
	end

	config.on = true

	-- Checks whether current buffer is inside a vault and is opening a file,
	-- should directly open the file.
	handlers.open_file()
end

-- Function to disable the plugin
function Off()
	config.on = false
end

-- Register commands to Neovim to access Obsidian API endpoints
M.register = function()
	vim.cmd([[
        command! ObsidianNavigatorOn lua On()
        command! ObsidianNavigatorOff lua Off()
        command! ObsidianNavigatorToday lua require("obsidian-navigator.handlers").open_today_daily_note()
    ]])
end

return M
