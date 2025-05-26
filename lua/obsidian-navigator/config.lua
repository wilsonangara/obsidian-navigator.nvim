local M = {}

-- Indicates whether the plugin is enabled or disabled.
M.on = true

M.setup_config = function()
	-- Note: for now we are hardcoding the obsidian base URL.
	local default_config = {
		obsidial_base_url = "http://localhost:27124",
		obsidian_vaults = {},
	}
	M.config = default_config
end

return M
