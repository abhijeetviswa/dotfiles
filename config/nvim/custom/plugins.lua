local overrides = require("custom.configs.overrides")
local merge_tb = vim.tbl_deep_extend

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options

	{
		"nvim-telescope/telescope.nvim",
		opts = function()
			local config = {
				defaults = {
					mappings = {
						n = {
							["<C-p>"] = require("telescope.actions.layout").toggle_preview,
						},
						i = {
							["<C-p>"] = require("telescope.actions.layout").toggle_preview,
						},
					},
					preview = {
						hide_on_startup = true, -- hide previewer when picker starts
					},
				},
			}
			local default_config = require("plugins.configs.telescope")

			return merge_tb("force", default_config, config)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"pmizio/typescript-tools.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
				priority = 99,
				event = { pattern = { "*.js", "*.ts", "*.tsx", "*.jsx" } },
				opts = function()
					return require("custom.configs.lsps.typescript-tools")
				end,
			},
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				priority = 100, -- Must be one greather than typescript-tools so it gets attached first
				config = function()
					require("custom.configs.null-ls")
				end,
			},
			{
				"kevinhwang91/nvim-ufo",
				event = "VeryLazy",
				dependencies = {
					"kevinhwang91/promise-async",
				},
				config = function()
					require("ufo").setup()
				end,
			},
		},
		config = function()
			require("custom.configs.lspconfig")
			require("custom.configs.lsps.init")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		version = "*",
		config = function()
			require("custom.configs.dap").setup()
		end,
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				config = require("custom.configs.dapui"),
			},
		},
	},
	{
		"rcarriga/nvim-notify",
	},
	-- {
	-- 	"exafunction/codeium.vim",
	-- 	event = "BufReadPost",
	-- 	init = function(_)
	-- 		require("core.utils").load_mappings("codeium")
	-- 	end,
	-- },
	{
		"github/copilot.vim",
		event = "BufReadPost",
		init = function(_)
			vim.g.copilot_no_tab_map = true
			require("core.utils").load_mappings("copilot")
		end,
	},
	{
		"luukvbaal/statuscol.nvim",
		lazy = false,
		config = function()
			require("custom.configs.statuscol")
		end,
	},
	{
		"LudoPinelli/comment-box.nvim",
		event = "BufReadPost",
	},
	{
		"SmiteshP/nvim-navic",
		event = "VeryLazy",
	},
	{
		"leoluz/nvim-dap-go",
		event = "BufReadPost",
		opts = {
			-- Additional dap configurations can be added.
			-- dap_configurations accepts a list of tables where each entry
			-- represents a dap configuration. For more details do:
			-- :help dap-configuration
			dap_configurations = {
				{
					-- Must be "go" or it will be ignored by the plugin
					type = "go",
					name = "Attach remote",
					mode = "remote",
					request = "attach",
				},
			},
			-- delve configurations
			delve = {
				-- the path to the executable dlv which will be used for debugging.
				-- by default, this is the "dlv" executable on your PATH.
				path = "dlv",
				-- time to wait for delve to initialize the debug session.
				-- default to 20 seconds
				initialize_timeout_sec = 20,
				-- a string that defines the port to start delve debugger.
				-- default to string "${port}" which instructs nvim-dap
				-- to start the process in a random available port
				port = "${port}",
				-- additional args to pass to dlv
				args = {},
				-- the build flags that are passed to delve.
				-- defaults to empty string, but can be used to provide flags
				-- such as "-tags=unit" to make sure the test suite is
				-- compiled during debugging, for example.
				-- passing build flags using args is ineffective, as those are
				-- ignored by delve in dap mode.
				build_flags = "",
				-- whether the dlv process to be created detached or not. there is
				-- an issue on Windows where this needs to be set to false
				-- otherwise the dlv server creation will fail.
				detached = true,
				-- the current working directory to run dlv from, if other than
				-- the current working directory.
				cwd = nil,
			},
		},
		dependencies = {
			{
				"nvim-neotest/nvim-nio",
			},
		},
	},
	{ "kevinhwang91/nvim-bqf", lazy = false },
	{ "numToStr/BufOnly.nvim", lazy = true, cmd = "BufOnly" },
}

return plugins
