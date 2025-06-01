local config = require("obsidian-navigator.config")

local M = {}

-- Returns boolean value on whether the current working directory is inside
-- one of the vaults registered in the configuration.
M.is_inside_vault = function()
	local cwd = vim.fn.getcwd()
	for _, path in ipairs(config.config.obsidian_vaults) do
		-- Compare path to directory
		if path == cwd:sub(1, #path + 1) then
			return true
		end
	end
	return false
end

return M
