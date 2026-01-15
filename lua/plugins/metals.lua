return {
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    ft = { "scala", "sbt", "java" },
    config = function()
      local metals = require("metals")
      local metals_config = metals.bare_config()

      -- Enable DAP integration (this is the missing middle layer)
      metals_config.on_attach = function(client, bufnr)
        metals.setup_dap()
      end

      -- Auto-start Metals for Scala/SBT buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java" },
        callback = function()
          metals.initialize_or_attach(metals_config)
        end,
        group = vim.api.nvim_create_augroup("Metals", { clear = true }),
      })
    end,
  },
}

