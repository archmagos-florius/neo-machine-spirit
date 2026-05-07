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

      local metals_group = vim.api.nvim_create_augroup("Metals", { clear = true })

      metals_config.on_attach = function(client, bufnr)
        metals.setup_dap()

        local opts = { buffer = bufnr, silent = true, noremap = true }
        vim.keymap.set("n", "<leader>mr", vim.lsp.codelens.run, vim.tbl_extend("force", opts, { desc = "Metals Run CodeLens" }))
        vim.keymap.set(
          "n",
          "<leader>ms",
          metals.select_test_suite,
          vim.tbl_extend("force", opts, { desc = "Metals Select Test Suite" })
        )
        vim.keymap.set(
          "n",
          "<leader>mt",
          metals.select_test_case,
          vim.tbl_extend("force", opts, { desc = "Metals Select Test Case" })
        )

        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = bufnr,
          group = metals_group,
          callback = function()
            pcall(vim.lsp.codelens.refresh)
          end,
        })

        pcall(vim.lsp.codelens.refresh)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java" },
        callback = function()
          metals.initialize_or_attach(metals_config)
        end,
        group = metals_group,
      })
    end,
  },
}
