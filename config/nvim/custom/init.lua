local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*", command = "tabdo wincmd =",
-- })
--

vim.opt.clipboard = ""

vim.wo.number = true
vim.wo.relativenumber = true

autocmd("BufWritePre", {
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.ejs",
	command = "set filetype=ejs",
})

autocmd("FileType", {
	pattern = "yaml",
	callback = function()
		print("File is yaml!")
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = true
	end,
})

autocmd("Syntax", {
	pattern = "ejs",
	command = "runtime! syntax/html.vim",
})

-- Snippet paths:
vim.g.vscode_snippets_path = vim.fn.stdpath("config") .. "/vscode-snippets/" -- vscode format
-- vim.g.snipmate_snippets_path = "your snippets path" -- snipmate format
-- vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/custom/lua_snippets" -- lua format

-- Fold Stuff
vim.opt.fillchars = {
	foldopen = "▼",
	foldclose = "▶",
	foldsep = " ",
}

vim.o.foldcolumn = "auto"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
