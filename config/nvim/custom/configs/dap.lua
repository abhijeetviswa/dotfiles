return function()
  require("dap").adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = 8123, -- default port
    executable = {
      command = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug-adapter",
    },
  }

  for _, language in ipairs { "typescript", "javascript" } do
    require("dap").configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        address = "localhost",
        port = 9229,
        cwd = "${workspaceFolder}",
        continueOnAttach = true,
      },
    }
  end
end
