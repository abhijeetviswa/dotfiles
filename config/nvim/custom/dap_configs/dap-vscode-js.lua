return function()
  require("dap-vscode-js").setup {
    debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
    debugger_cmd = { "js-debug-adapter" },
    adapters = {
      "pwa-node",
      "node-terminal",
      "pwa-extensionHost",
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
        attachSimplePort = 9229,
        cwd = "${workspaceFolder}",
        continueOnAttach = true,
      },
    }
  end
end
