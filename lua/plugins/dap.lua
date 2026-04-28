return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "nvim-neotest/nvim-nio" },
      { "theHamsta/nvim-dap-virtual-text" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local php_debug_path = vim.fn.expand("~/.local/share/nvim/dap-adapters/vscode-php-debug/out/phpDebug.js")

      dapui.setup()
      require("nvim-dap-virtual-text").setup({})

      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { php_debug_path },
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003,
          pathMappings = {
            ["/ebs1/www"] = "${workspaceFolder}",
          },
          hostname = "0.0.0.0",
          stopOnEntry = false,
          log = false,
          xdebugSettings = {
            max_children = 256,
            max_data = 2048,
            max_depth = 5,
          },
        },
        {
          type = "php",
          request = "launch",
          name = "Current PHP file",
          port = 9003,
          program = "${file}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          runtimeExecutable = "php",
          stopOnEntry = false,
        },
      }

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Keymaps
      local map = vim.keymap.set
      map("n", "<F5>", dap.continue, { desc = "DAP continue" })
      map("n", "<F10>", dap.step_over, { desc = "DAP step over" })
      map("n", "<F11>", dap.step_into, { desc = "DAP step into" })
      map("n", "<F12>", dap.step_out, { desc = "DAP step out" })
      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
      map("n", "<leader>dc", dap.run_to_cursor, { desc = "DAP run to cursor" })
      map("n", "<leader>du", dapui.toggle, { desc = "DAP UI toggle" })
    end,
  },
}
