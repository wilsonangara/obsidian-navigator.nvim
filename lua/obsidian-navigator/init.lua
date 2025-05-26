local config = require("obsidian-navigator.config")

local M = {}

vim.api.nvim_create_augroup("obsidian-navigator.nvim", { clear = true })

-- Initialize the plugin configuration.
local function init()
	-- Checks whether the plugin is enabled.
	if not config.on then
		return
	end

	-- Checks whether the current working directory
end

function M.setup()
	vim.api.nvim_create_autocmd("BufEnter", {
		callback = init,
		pattern = "*",
		group = "obsidian-navigator.nvim",
	})
end

return M
