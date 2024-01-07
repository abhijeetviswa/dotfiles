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
		["<leader>bdo"] = { "<cmd> %bd|e#|bd#<CR>", "Close all buffers but current open", opts = { remap = false } },

		-- Find
		["<leader>ff"] = { "<cmd> Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", "Find Files" },
		-- ["<leader>fg"] = { "<cmd> Telescope find_files grep_string=rg,--ignore,--hidden,--files<CR>" }, -- Does not work
		["<leader>fa"] = {
			"<cmd> Telescope find_files find_command=rg,--no-ignore,--hidden,--follow,--files,--ignore-files=.git<CR>",
			"Find all",
		},
		--
	},
	v = {
		-- Clipboard actions
		["<leader>y"] = { '"*y', "Copy to clipboard", opts = { remap = true } },
		["<leader>p"] = { '"*p', "Paste from clipboard", opts = { remap = true } },
	},
	t = {
		["<C-/>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
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
		["<F5>"] = {
			function()
				require("dap").continue()
				require("dapui").open({})
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
			end,
			"Start/Continue debugger",
		},
		["<leader>dt"] = {
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
	},
}

-- M.debugging = {
--   plugin = true,
--   n = {
--     ["<F5>"] = {
--       function()
--         require("dap").continue()
--       end,
--       "Start/Continue debugger",
--     },
--     ["<F8>"] = {
--       function()
--         require("dap").step_into()
--       end,
--       "Step into",
--     },
--     ["<F9>"] = {
--       function()
--         require("dap").step_over()
--       end,
--       "Step over",
--     },
--     ["<leader>dd"] = {
--       function()
--         require("dap").toggle_breakpoint()
--       end,
--       "Toggle Breakpoint",
--     },
--     ["<F2>"] = {
--       function()
--         require("dap").repl.toggle()
--       end,
--       "Toggle REPL",
--     },
--     ["<leader>dh"] = {
--       function()
--         require("dap.ui.widgets").hover()
--       end,
--       "DAP Hover",
--     },
--     ["<leader>df"] = {
--       function()
--         local widgets = require "dap.ui.widgets"
--         widgets.centered_float(widgets.frames)
--       end,
--       "DAP Frames",
--     },
--     ["<leader>ds"] = {
--       function()
--         local widgets = require "dap.ui.widgets"
--         widgets.centered_float(widgets.scopes)
--       end,
--     },
--     ["<leader>dp"] = {
--       function()
--         require("dap.ui.widgets").preview()
--       end,
--       "DAP Scopes",
--     },
--     ["<leader>dz"] = {
--       function()
--         require("dap").focus_frame()
--       end,
--       "Focus Debug Frame",
--     },
--   },
-- }

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
				print("Clear suggestion")
				return vim.fn["codeium#Clear"]()
			end,
			"Clear Suggestion",
		},
		-- vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
		-- vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
		-- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
		-- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
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
-- more keybinds!

return M
