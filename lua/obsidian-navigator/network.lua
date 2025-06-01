local curl = require("plenary.curl")
local config = require("obsidian-navigator.config")

local M = {}

-- Creates an HTTP request to the Obsidian API
local function request(method, endpoint, data)
	-- Send the request using plenary.curl
	local result = curl.request({
		url = config.config.obsidial_base_url .. endpoint,
		method = method,
		headers = {
			["Content-Type"] = "application/json",
		},
		body = data and vim.fn.json_encode(data) or nil,
		on_error = function()
			-- Do nothing
		end,
	})

	-- Decode JSON response if the result is not empty
	if result.body and result.body ~= "" then
		local ok, decoded = pcall(vim.fn.json_decode, result.body)
		if not ok then
			vim.api.nvim_err_writeln("Invalid JSON from " .. endpoint)
			return
		end
		return decoded
	end
end

-- Method to send GET requests
M.get = function(endpoint)
	return request("GET", endpoint, nil)
end

-- Method to send POST requests
M.post = function(endpoint, payload)
	return request("POST", endpoint, payload)
end

return M
