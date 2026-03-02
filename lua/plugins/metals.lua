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

      -- CRITICAL: enable completion capabilities for Metals
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end
      metals_config.capabilities = capabilities

      -- Optional: keep your DAP integration
      metals_config.on_attach = function(client, bufnr)
        metals.setup_dap()
      end

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
