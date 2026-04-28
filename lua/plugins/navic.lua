-- ~/.config/nvim/lua/plugins/navic.lua
return {
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      highlight = true,
      separator = " > ",
      depth_limit = 5,
    },
  },
}
