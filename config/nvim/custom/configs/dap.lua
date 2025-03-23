local dap = require("dap")
local dap_ext_vscode = require("dap.ext.vscode")

local M = {}

M.reload_launchjs = function()
	dap_ext_vscode.load_launchjs(nil, { ["pwa-node"] = { "javascript", "typescript" } })
end

M.setup = function()
	M.reload_launchjs()

	dap.adapters["pwa-node"] = {
		type = "server",
		host = "localhost",
		port = 8123, -- default port
		executable = {
			command = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug-adapter",
		},
	}
end

return M
