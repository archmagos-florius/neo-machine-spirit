return {
    {
	'navarasu/onedark.nvim',
	config = function()
	    require('onedark').setup { style = 'deep' }
	    require('onedark').load()
	    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
	end
    },
    {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = { theme = 'onedark' },
    },
}
