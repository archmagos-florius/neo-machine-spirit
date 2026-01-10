return {
    'nvim-treesitter/nvim-treesitter',
    branch	= 'main',
    version 	= false,
    opts_extend	= { 'ensure_installed' },
    opts	= {
	highlight 		= { enable = true },
	indent 			= { enable = true },
	autoage 		= { enable = true },
	sync_install 		= false,
	auto_install 		= false,
	ensure_installed 	= {
	    'lua',
	    'tsx',
	    'typescript',
	    'php',
	    'java',
	    'scala'
	},
    }
}
