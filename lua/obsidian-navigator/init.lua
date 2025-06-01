local config = require("obsidian-navigator.config")

local M = {}

vim.api.nvim_create_augroup("obsidian-navigator.nvim", { clear = true })

-- Initialize the plugin configuration.
local function init()
	-- Checks whether the current working directory, if yes turn on the plugin.
	local cwd = vim.fn.getcwd()
	local inside_directory = false
	for _, path in ipairs(config.config.obsidian_vaults) do
		-- Compare path to directory
		if path == cwd:sub(1, #path + 1) then
			config.on = true
			inside_directory = true
			break
		end
	end
	if not inside_directory then
		config.on = false
		return
	end
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
