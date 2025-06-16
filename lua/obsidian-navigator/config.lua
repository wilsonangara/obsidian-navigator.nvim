local M = {}

-- Indicates whether the plugin is enabled or disabled.
M.on = true

M.setup_config = function(user_config)
	-- Defaults to an empty table if no user configuration is provided.
	user_config = user_config or {}

	-- Note: for now we are hardcoding the obsidian base URL.
	local default_config = {
		obsidial_base_url = "http://localhost:27124",
		obsidian_vaults = user_config.vaults or {},
		obsidian_scroll_sync = user_config.scroll_sync or false,
	}
	M.config = default_config
end

return M
