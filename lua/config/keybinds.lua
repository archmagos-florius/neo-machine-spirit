-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader 	= " "
vim.g.maplocalleader 	= " "


local opts = { buffer = bufnr, silent = true }
vim.keymap.set('n', '<leader>cd', vim.cmd.Ex)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, { focus = false })
end, { noremap = true, silent = true, desc = "Explain diagnostic" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next()
  vim.diagnostic.open_float(nil, { focus = false })
end, { noremap = true, silent = true, desc = "Next diagnostic" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev()
  vim.diagnostic.open_float(nil, { focus = false })
end, { noremap = true, silent = true, desc = "Prev diagnostic" })

