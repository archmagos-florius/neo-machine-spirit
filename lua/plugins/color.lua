return {
    {
	'navarasu/onedark.nvim',
	config = function()
	    require('onedark').setup { style = 'deep' }
	    require('onedark').load()
	    local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
	    vim.api.nvim_set_hl(0, 'Normal', { fg = normal.fg, bg = 'none' })
	end
    },
    {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = { theme = 'onedark' },
    },
}
