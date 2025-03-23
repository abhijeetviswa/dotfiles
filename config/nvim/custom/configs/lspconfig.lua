local navic = require("nvim-navic")

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local M = {}

M.on_attach = function(client, bufnr)
	on_attach(client, bufnr)
	navic.attach(client, bufnr)
end

M.capabilities = capabilities

return M
