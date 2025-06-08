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
	-- Plugin commands
	vim.cmd([[
        command! ObsidianNavigatorOn lua On()
        command! ObsNavOn lua On()

        command! ObsidianNavigatorOff lua Off()
        command! ObsNavOff lua Off()
    ]])

	-- Daily Notes commands
	vim.cmd([[
        command! ObsidianNavigatorTodayDailyNote lua require("obsidian-navigator.handlers").open_today_daily_note()
        command! ObsNavTodayDailyNote lua require("obsidian-navigator.handlers").open_today_daily_note()

        command! ObsidianNavigatorNextDailyNote lua require("obsidian-navigator.handlers").open_next_daily_note()
        command! ObsNavNextDailyNote lua require("obsidian-navigator.handlers").open_next_daily_note()

        command! ObsidianNavigatorPrevDailyNote lua require("obsidian-navigator.handlers").open_prev_daily_note()
        command! ObsNavPrevDailyNote lua require("obsidian-navigator.handlers").open_prev_daily_note()
    ]])

	-- Workspace tab commands
	vim.cmd([[
        command! ObsidianNavigatorNewTab lua require("obsidian-navigator.handlers").new_tab()
        command! ObsNavNewTab lua require("obsidian-navigator.handlers").new_tab()

        command! ObsidianNavigatorNextTab lua require("obsidian-navigator.handlers").next_tab()
        command! ObsNavNextTab lua require("obsidian-navigator.handlers").next_tab()

        command! ObsidianNavigatorPrevTab lua require("obsidian-navigator.handlers").prev_tab()
        command! ObsNavPrevTab lua require("obsidian-navigator.handlers").prev_tab()

        command! ObsidianNavigatorCloseTab lua require("obsidian-navigator.handlers").close_tab()
        command! ObsNavCloseTab lua require("obsidian-navigator.handlers").close_tab()

        command! ObsidianNavigatorCloseOtherTabs lua require("obsidian-navigator.handlers").close_other_tabs()
        command! ObsNavCloseOtherTabs lua require("obsidian-navigator.handlers").close_other_tabs()
    ]])
end

return M
