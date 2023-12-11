local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = custom_on_attach,
    capabilities = capabilities,
  }
end

lspconfig.tsserver.setup {
  init_options = {
    preferences = {
      includeInlayParameterNameHints = "all",
      importModuleSpecifierPreference = "relative",
    },
  },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- Disable tsserver's formatting capabilities
    client.server_capabilities.document_formatting = false
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.buf.inlay_hint.enable(bufnr, true)
    end
  end,
  capabilities = capabilities,
}

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
