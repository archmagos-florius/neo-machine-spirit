return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "nvim-neotest/nvim-nio" }, -- required by dap-ui
      { "theHamsta/nvim-dap-virtual-text" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- -------------------------
      -- DAP UI
      -- -------------------------
      dapui.setup()
      require("nvim-dap-virtual-text").setup({})

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- -------------------------
      -- Scala/JVM attach config (JDWP)
      -- -------------------------
      -- This attaches to: sbt -jvm-debug 5005
      dap.adapters.scala = function(callback, _)
        callback({
          type = "server",
          host = "127.0.0.1",
          port = 5005,
        })
      end

      dap.configurations.scala = {
        {
          type = "scala",
          request = "attach",
          name = "Attach to sbt (JDWP :5005)",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }

      -- If your Scala files use filetype "scala", you're good.
      -- If not, you can also map java/kotlin similarly.
      dap.configurations.java = dap.configurations.scala

      -- -------------------------
      -- Keymaps (feel free to change)
      -- -------------------------
      local map = vim.keymap.set
      map("n", "<F5>", function() dap.continue() end, { desc = "DAP continue/attach" })
      map("n", "<F10>", function() dap.step_over() end, { desc = "DAP step over" })
      map("n", "<F11>", function() dap.step_into() end, { desc = "DAP step into" })
      map("n", "<F12>", function() dap.step_out() end, { desc = "DAP step out" })

      map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "DAP toggle breakpoint" })
      map("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP conditional breakpoint" })

      map("n", "<leader>dr", function() dap.repl.open() end, { desc = "DAP REPL" })
      map("n", "<leader>du", function() dapui.toggle() end, { desc = "DAP UI toggle" })
      map("n", "<leader>dx", function() dap.terminate() end, { desc = "DAP terminate" })
    end,
  },
}
