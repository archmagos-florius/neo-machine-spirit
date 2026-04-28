vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { silent = true })

-- LSP (works when an LSP is attached; these won’t error if no LSP)
vim.keymap.set("n", "<leader>hov", function() vim.lsp.buf.hover() end, { silent = true })
vim.keymap.set("n", "<leader>def", function() vim.lsp.buf.definition() end, { silent = true })
vim.keymap.set("n", "<leader>dec", function() vim.lsp.buf.declaration() end, { silent = true })
vim.keymap.set("n", "<leader>imp", function() vim.lsp.buf.implementation() end, { silent = true })
vim.keymap.set("n", "<leader>ref", function() vim.lsp.buf.references() end, { silent = true })
vim.keymap.set("n", "<leader>ren", function() vim.lsp.buf.rename() end, { silent = true })
vim.keymap.set("n", "<leader>act", function() vim.lsp.buf.code_action() end, { silent = true })

vim.keymap.set("n", "<leader>dia", function()
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

vim.keymap.set('t','<leader><Esc>',[[<C-\><C-n>]])
