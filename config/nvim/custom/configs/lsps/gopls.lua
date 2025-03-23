local lspconfig = require("lspconfig")

local on_attach = require("custom.configs.lspconfig").on_attach
local capabilities = require("custom.configs.lspconfig").capabilities

lspconfig.gopls.setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)

		-- Setup auto commands for formatting
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		gopls = {
			gofumpt = true,
			experimentalPostfixCompletions = true,
			staticcheck = true,
			usePlaceholders = true,
		},
	},
})
