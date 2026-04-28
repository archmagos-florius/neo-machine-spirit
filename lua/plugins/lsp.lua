return {
  -- Mason (installs LSP servers)
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "gopls",
        "intelephense",
      },
    },
  },

  -- Completion engine (this is what actually shows suggestions)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
      })
    end,
  },

  -- You're using Neovim 0.11's built-in LSP config API (vim.lsp.config / vim.lsp.enable)
  {
    "neovim/nvim-lspconfig",
    enabled = false,
  },
  {
    "SmiteshP/nvim-navic",
    lazy = false,
  },
  -- ✅ Core LSP wiring (runs at startup; no "anchor plugin" needed)
  {
    "nvim-lua/plenary.nvim",
    lazy = false, -- IMPORTANT: ensure this runs early so configs are registered
    config = function()
      local function mason_bin(exe)
        local p = vim.fn.stdpath("data") .. "/mason/bin/" .. exe
        if vim.fn.executable(p) == 1 then
          return p
        end
        return exe -- fallback to PATH
      end

      -- Completion capabilities (needed for nvim-cmp)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- Avoid duplicate autocmds if you reload config
      local augroup = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        callback = function(args)
          local buf = args.buf
          local opts = { buffer = buf, silent = true, noremap = true }
	  local clients = vim.lsp.get_clients({ bufnr = buf })
	  local client = clients[1]
	  local has_symbols =
	  (client.server_capabilities and client.server_capabilities.documentSymbolProvider)
	  or (client.capabilities and client.capabilities.documentSymbolProvider)

          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	  
	  if has_symbols then
	    require("nvim-navic").attach(client, buf)
	  end
        end,
      })

      -- TSX
      vim.lsp.config("ts_ls", {
	  cmd = { mason_bin("typescript-language-server"), "--stdio" },
	  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	  capabilities = capabilities,
      })
      vim.lsp.enable("ts_ls")

      -- Go
      vim.lsp.config("gopls", {
        cmd = { mason_bin("gopls") },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
        capabilities = capabilities,
      })
      vim.lsp.enable("gopls")

      -- PHP
      vim.lsp.config("intelephense", {
        cmd = { mason_bin("intelephense"), "--stdio" },
        filetypes = { "php" },
        root_markers = { "composer.json", ".git" },
        single_file_support = true,
        capabilities = capabilities,
      })
      vim.lsp.enable("intelephense")
    end,
  },
}
