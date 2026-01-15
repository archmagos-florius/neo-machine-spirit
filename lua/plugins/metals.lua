return {
  {
    "scalameta/nvim-metals",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "scala", "sbt", "java" },
    config = function()
      local metals_config = require("metals").bare_config()

      metals_config.on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      end

      -- Optional: better completion support if you already use nvim-cmp
      -- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      local augroup = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java" },
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = augroup,
      })
    end,
  },
}
