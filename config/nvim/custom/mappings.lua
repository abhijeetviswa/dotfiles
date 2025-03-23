---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		[":"] = { ";", "repeat latest f, t, F or T", opts = { remap = false } },
		["<leader>q"] = { "<leader>x", "Close buffer", opts = { remap = true } },
		["<leader>cd"] = { ":cd %:h<CR>", "CD to current directory" },

		["<space>ts"] = { "<A-h>", "Toggle horizontal terminal", opts = { remap = true } },
		["<space>tv"] = { "<A-v>", "Toggle vertical terminal", opts = { remap = true } },

		-- Clipboard actions
		["<leader>y"] = { '"*y', "Copy to clipboard", opts = { remap = true } },
		["<leader>p"] = { '"*p', "Paste from clipboard", opts = { remap = true } },

		-- Buffer helpers
		["<leader>bd"] = { "<cmd> %bd<CR>", "Close all buffers", opts = { remap = false } },
		["<leader>bdo"] = { "<cmd>BufOnly<CR>", "Close all buffers but current open", opts = { remap = false } },

		-- Find
		["<leader>ff"] = {
			"<cmd> Telescope find_files find_command=rg,--ignore,--hidden,--files,--iglob=!.git/<CR>",
			"Find Files",
		},
		["<leader>fa"] = {
			"<cmd> Telescope find_files find_command=rg,--no-ignore,--hidden,--follow,--files,--iglob=!.git/<CR>",
			"Find all",
		},

		["<leader>ft"] = {
			"<cmd> Telescope filetypes<CR>",
			"List Filetypes",
		},
		["<leader>fw"] = {
			function()
				require("telescope.builtin").live_grep({ additional_args = { "--hidden", "--glob=!.git/" } })
			end,
			"Live grep",
		},

		["<leader>qf"] = {
			"<cmd> copen<CR>",
			"Open quickfix",
		},

		["<leader>lgc"] = {
			"<cmd> Telescope git_bcommits<CR>",
			"Git blame buffer",
		},
		["<C-'>"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"LSP signature help",
		},
	},
	v = {
		-- Clipboard actions
		["<leader>y"] = { '"*y', "Copy to clipboard", opts = { remap = true } },
		["<leader>p"] = { '"*p', "Paste from clipboard", opts = { remap = true } },
	},
	t = {
		["<C-/>"] = {
			vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
			"Escape terminal mode",
		},
	},
	i = {
		["<C-'>"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"LSP signature help",
		},
	},
}

-- -- Close debugger and clear breakpoints
-- vim.keymap.set("n", "<localleader>de", function()
--   dap.clear_breakpoints()
--   ui.toggle {}
--   dap.terminate()
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
--   require "notify"("Debugger session ended", "warn")
-- end)

M.debugging = {
	n = {
		["<F2>"] = {
			function()
				require("custom.configs.dap").reload_launchjs()
			end,
			"Reload Launch Config",
		},
		["<F5>"] = {
			function()
				require("dap").continue()
				require("dapui").open({})
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
			end,
			"Start/Continue debugger",
		},
		["<leader><leader>d"] = {
			function()
				require("dapui").toggle()
			end,
			"Toogle Debug UI,",
		},
		["<leader>dl"] = {
			function()
				require("dap.ui.widgets").hover()
			end,
			"Debugger hover",
		},
		["<leader>db"] = {
			function()
				require("dap").toggle_breakpoint()
			end,
			"Toggle breakpoint",
		},
		["<F9>"] = {
			function()
				require("dap").step_over()
			end,
			"Step over",
		},
		["<F8>"] = {
			function()
				require("dap").step_into()
			end,
			"Step into",
		},
		["<F7>"] = {
			function()
				require("dap").step_out()
			end,
			"Step out",
		},
		["<leader>dC"] = {
			function()
				require("dap").clear_breakpoints()
				require("notify")("Breakpoints cleared", "warn")
			end,
		},
		["<leader>de"] = {
			function()
				require("dap").clear_breakpoints()
				require("ui").toggle({})
				require("dap").terminate()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
				require("notify")("Debugger session ended", "warn")
			end,
			"End Debugger",
		},
		["<leader>dr"] = {
			function()
				require("dap").run_to_cursor()
			end,
			"Run to Cursor",
		},
		["<leader>dz"] = {
			function()
				require("dap").focus_frame()
			end,
			"Focus Frame",
		},
	},
}

M.codeium = {
	plugin = true,
	i = {
		["<C-d>"] = {
			function()
				return vim.fn["codeium#Accept"]()
			end,
			"Accept Suggestion",
			opts = { expr = true },
		},
		["<C-\\>"] = {
			function()
				return vim.fn["codeium#CycleCompletions"](1)
			end,
			"Next Suggestion",
			opts = { expr = true },
		},
		["<C-]>"] = {
			function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end,
			"Prev Suggestion",
			opts = { expr = true },
		},
		["<C-x>"] = {
			function()
				return vim.fn["codeium#Clear"]()
			end,
			"Clear Suggestion",
		},
	},
}

M.copilot = {
	plugin = true,
	i = {
		["<C-d>"] = {
			'copilot#Accept("")',
			"Accept Suggestion (block)",
			opts = { expr = true, silent = true, replace_keycodes = false },
		},
		["<M-d>"] = {
			"<Plug>(copilot-accept-line)",
			"Accept Suggestion (line)",
		},
		["<C-\\>"] = {
			"<Plug>(copilot-next)",
			"Next Suggestion",
			opts = { remap = true },
		},
		["<C-]>"] = {
			"<Plug>(copilot-previous)",
			"Prev Suggestion",
			opts = { remap = true },
		},
		["<C-x>"] = {
			"<Plug>(copilot-clear)",
			"Clear Suggestion",
			opts = { remap = true },
		},
	},
}

M.ufo = {
	plugin = true,
	n = {
		["zR"] = {
			function()
				require("ufo").closeAllFolds()
			end,
			"Fold Close",
			opts = { remap = true },
		},
		["zM"] = {
			function()
				require("ufo").openAllFolds()
			end,
			"Fold Open",
			opts = { remap = true },
		},
	},
}

M.comment_box = {
	n = {
		["<leader>cb"] = {
			"<cmd>CBalbox10<CR>",
			"Create Comment Box",
			{ noremap = true, silent = true },
		},
	},
	v = {
		["<leader>cb"] = {
			"<cmd>'<,'>CBalbox10<CR>",
			"Create Comment Box",
			{ noremap = true, silent = true },
		},
	},
}

M.lspconfig = {
	n = {
		["gD"] = {
			function()
				local ts_tools_declaration = require("typescript-tools.api").go_to_source_definition
				local switch = {
					["typescript"] = ts_tools_declaration,
					["javascript"] = ts_tools_declaration,
					["typescriptreact"] = ts_tools_declaration,
					["javascriptreact"] = ts_tools_declaration,
				}
				local ft = vim.bo.filetype

				if switch[ft] then
					switch[ft]()
				else
					vim.lsp.buf.declaration()
				end
			end,
			"LSP Declaration",
		},
		["<leader>lr"] = {
			"<cmd> Telescope lsp_references<CR>",
			"List LSP References",
		},
	},
}

return M
