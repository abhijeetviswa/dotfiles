local on_attach = require("custom.configs.lspconfig").on_attach
local capabilities = require("custom.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "clangd", "texlab" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

require("custom.configs.lsps.typescript-tools")
require("custom.configs.lsps.gopls")
