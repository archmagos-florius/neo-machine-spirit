return {
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

    -- ✅ No nvim-lspconfig needed for Go/PHP on Neovim 0.11+
    {
	"neovim/nvim-lspconfig",
	enabled = false, -- keep it disabled to avoid the deprecated framework path
    },

    {
	"nvim-lua/plenary.nvim", -- harmless dependency for other plugins; safe to keep
    },

    {
	-- Core LSP wiring using Neovim 0.11 API
	"folke/lazy.nvim", -- dummy anchor so this runs (you can remove this block if you prefer a separate init file)
	config = function()
	    -- Keymaps when any LSP attaches
	    vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
		    local buf = args.buf
		    local opts = { buffer = buf, silent = true, noremap = true }

		    -- === Navigation ===
		    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

		    -- === Hover / Help ===
		    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		    vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)

		    -- === Refactor ===
		    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		end,
	    })
	    -- Neovim 0.11+ server configs
	    vim.lsp.config("gopls", {
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.work", "go.mod", ".git" },
	    })
	    vim.lsp.enable("gopls")

	    vim.lsp.config("intelephense", {
		cmd = { "intelephense", "--stdio" },
		filetypes = { "php" },
		root_markers = { "composer.json", ".git" },
	    })
	    vim.lsp.enable("intelephense")
	end,
    },
}
