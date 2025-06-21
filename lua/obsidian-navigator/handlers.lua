local config = require("obsidian-navigator.config")
local network = require("obsidian-navigator.network")
local utils = require("obsidian-navigator.utils")

local M = {}

local scroll_sync_group = "obsidian-navigator-scroll-sync"

-- Helper function to execute a command when plugin is enabled, and do nothing
-- when disabled.
local function exec_cmd(fn)
	if config.on then
		fn()
	end
end

-- Run any handlers that should be executed when the plugin is enabled.
M.on_buf_enter = function()
	exec_cmd(M.open_file)
end

-- ================================ WORKSPACE ================================

-- Opens a file where the obsidian vault buffer is opened from.
M.open_file = function()
	-- Get file from the current buffer
	local filepath = vim.fn.expand("%:.")
	if filepath ~= "" then
		network.post("/workspace/open-link-text", { filepath = filepath })
	end
end

M.open_graph = function()
	exec_cmd(function()
		network.post("/workspace/graph", {})
	end)
end

-- =============================== DAILY NOTES ===============================

-- Opens today's daily note.
M.open_today_daily_note = function()
	exec_cmd(function()
		local res = network.post("/daily-notes/today", {})
		if res ~= nil and res.filepath ~= nil then
			vim.cmd("edit " .. vim.fn.fnameescape(res.filepath))
		end
	end)
end

-- Opens the next daily note.
M.open_next_daily_note = function()
	exec_cmd(function()
		local res = network.post("/daily-notes/next", {})
		if res ~= nil and res.filepath ~= nil then
			vim.cmd("edit " .. vim.fn.fnameescape(res.filepath))
		end
	end)
end

-- Opens the previous daily note.
M.open_prev_daily_note = function()
	exec_cmd(function()
		local res = network.post("/daily-notes/prev", {})
		if res ~= nil and res.filepath ~= nil then
			vim.cmd("edit " .. vim.fn.fnameescape(res.filepath))
		end
	end)
end

-- ================================= CURSOR ==================================

-- Enables scroll sync between the Obsidian app and Neovim by registering
-- autocmd to sync the cursor position.
M.enable_scroll_sync = function()
	-- Remove any existing autocmds in the group to avoid duplicates.
	vim.api.nvim_create_augroup(scroll_sync_group, { clear = true })

	-- Creates a single timer specific for debouncing the scroll into view
	local debounce_scroll = utils.debounce(M.scroll_into_view, 400)

	-- Register an autocmd that triggers on CursorMoved in markdown files.
	vim.api.nvim_create_autocmd("CursorMoved", {
		callback = function()
			local line = vim.api.nvim_win_get_cursor(0)[1]
			debounce_scroll(line)
		end,
		pattern = "*.md",
		group = scroll_sync_group,
	})
end

-- Disables scroll sync between the Obsidian app and Neovim by unregistering
-- autocmd.
M.disable_scroll_sync = function()
	vim.api.nvim_clear_autocmds({ group = scroll_sync_group })
end

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
		local line = cursor[1] - 1 -- Obsidian's front matter starts at 0
		local col = cursor[2]

		local res = network.post("/editor/open-link", { line = line, ch = col })
		if res ~= nil and res.filepath ~= nil then
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
		local res = network.post("/workspace/tabs/next", {})
		if res ~= nil and res.filepath ~= nil then
			vim.cmd("edit " .. vim.fn.fnameescape(res.filepath))
		end
	end)
end

-- Moves to the previous tab (left) in the workspace if there is one.
M.prev_tab = function()
	exec_cmd(function()
		local res = network.post("/workspace/tabs/prev", {})
		if res ~= nil and res.filepath ~= nil then
			vim.cmd("edit " .. vim.fn.fnameescape(res.filepath))
		end
	end)
end

-- Closes the current tab in the workspace.
M.close_tab = function()
	exec_cmd(function()
		local res = network.post("/workspace/tabs/close", {})
		if res ~= nil and res.filepath ~= nil then
			vim.cmd("edit " .. vim.fn.fnameescape(res.filepath))
		end
	end)
end

-- Closes all tabs in the workspace except the current one.
M.close_other_tabs = function()
	exec_cmd(function()
		network.post("/workspace/tabs/close-others", {})
	end)
end

return M
