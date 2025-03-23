---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
  theme = "tokyonight",
  theme_toggle = { "tokyonight", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  statusline = {
    theme = "vscode_colored",
    overriden_modules = function(modules)
      table.remove(modules, 13)
      table.remove(modules, 10)
      table.remove(modules, 4)
      table.remove(modules, 3)
      table.remove(modules, 2)

      table.insert(modules, 2, "%#StText# " .. require("nvim-navic").get_location())
    end,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
