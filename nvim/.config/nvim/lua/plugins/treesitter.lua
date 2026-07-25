return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		opts = {
            auto_install = true,
			highlight = {
				enable = true,
			},
		},
	},
}
