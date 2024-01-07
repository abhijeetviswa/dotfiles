local overrides = require "custom.configs.overrides"
---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
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
      require "custom.configs.lspconfig"
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
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    version = "*",
    config = require "custom.configs.dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("dapui").setup {
            icons = { expanded = "▾", collapsed = "▸" },
            mappings = {
              open = "o",
              remove = "d",
              edit = "e",
              repl = "r",
              toggle = "t",
            },
            expand_lines = vim.fn.has "nvim-0.7",
            layouts = {
              {
                elements = {
                  "stacks",
                  "scopes",
                },
                size = 0.3,
                position = "right",
              },
              {
                elements = {
                  "repl",
                  "breakpoints",
                },
                size = 0.3,
                position = "bottom",
              },
            },
            floating = {
              max_height = nil,
              max_width = nil,
              border = "single",
              mappings = {
                close = { "q", "<Esc>" },
              },
            },
            windows = { indent = 1 },
            render = {
              max_type_length = nil,
            },
          }

          vim.fn.sign_define("DapBreakpoint", { text = "🐞" })
        end,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
  },
  {
    "exafunction/codeium.vim",
    event = "BufReadPost",
    init = function(_)
      require("core.utils").load_mappings "codeium"
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    lazy = false,
    config = function()
      require "custom.configs.statuscol"
    end,
  },
  {
    "LudoPinelli/comment-box.nvim",
    event = "BufReadPost",
  },
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
