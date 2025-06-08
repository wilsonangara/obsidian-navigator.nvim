local config = require("obsidian-navigator.config")
local network = require("obsidian-navigator.network")

local M = {}

-- Helper function to execute a command when plugin is enabled, and do nothing
-- when disabled.
local function exec_cmd(fn)
	if config.on then
		fn()
	end
end

-- Opens a file where the obsidian vault buffer is opened from.
M.open_file = function()
	-- Get file from the current buffer
	local filepath = vim.fn.expand("%:.")
	if filepath ~= "" then
		network.post("/workspace/open-link-text", { filepath = filepath })
	end
end

-- Run any handlers that should be executed when the plugin is enabled.
M.on_buf_enter = function()
	exec_cmd(M.open_file)
end

-- =============================== DAILY NOTES ===============================

-- Opens today's daily note.
M.open_today_daily_note = function()
	network.post("/daily-notes/today", {})
end

return M
