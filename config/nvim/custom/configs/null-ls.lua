local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {

  -- webdev stuff
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "javascript", "typescript", "yaml" } }, -- so prettier works only on these filetypes
  b.code_actions.eslint.with { filetypes = { "javascript", "typescript" } },

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- github actions
  b.diagnostics.actionlint,
}

null_ls.setup {
  debug = true,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { async = false, bufnr = bufnr }
        end,
      })
    end
  end,
  sources = sources,
}
