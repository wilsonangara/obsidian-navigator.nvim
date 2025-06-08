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
	exec_cmd(function()
		network.post("/daily-notes/today", {})
	end)
end

-- Opens the next daily note.
M.open_next_daily_note = function()
	exec_cmd(function()
		network.post("/daily-notes/next", {})
	end)
end

-- Opens the previous daily note.
M.open_prev_daily_note = function()
	exec_cmd(function()
		network.post("/daily-notes/prev", {})
	end)
end

-- ================================= CURSOR ==================================

-- Syncs the cursor position with the Obsidian app preview.
M.scroll_into_view = function(line)
	exec_cmd(function()
		network.post("/editor/scroll-into-view", { line = line })
	end)
end

-- Opens link under the cursor in the Obsidian app, and if the file exists,
-- opens it in the current Neovim buffer.
M.open_link = function()
	exec_cmd(function()
		local cursor = vim.api.nvim_win_get_cursor(0)
		local line = cursor[1]
		local col = cursor[2]

		local res = network.post("/editor/open-link", { line = line, ch = col })
		if res ~= nil then
			vim.cmd("edit " .. vim.fn.fnameescape(res.filepath))
		end
	end)
end

-- ================================== TABS ===================================

-- Opens the next tab in the workspace.
M.new_tab = function()
	exec_cmd(function()
		network.post("/workspace/tabs/new", {})
	end)
end

-- Moves to the next tab (right) in the workspace if there is one.
M.next_tab = function()
	exec_cmd(function()
		network.post("/workspace/tabs/next", {})
	end)
end

-- Moves to the previous tab (left) in the workspace if there is one.
M.prev_tab = function()
	exec_cmd(function()
		network.post("/workspace/tabs/prev", {})
	end)
end

-- Closes the current tab in the workspace.
M.close_tab = function()
	exec_cmd(function()
		network.post("/workspace/tabs/close", {})
	end)
end

-- Closes all tabs in the workspace except the current one.
M.close_other_tabs = function()
	exec_cmd(function()
		network.post("/workspace/tabs/close-others", {})
	end)
end

return M
