# OpenCode

This config uses [`opencode.nvim`](https://github.com/nickjvandyke/opencode.nvim) to integrate [OpenCode](https://opencode.ai/docs) directly into Neovim.

It is enhanced with [`snacks.nvim`](https://github.com/folke/snacks.nvim) for better input and picker UIs. See [`docs/snacks.md`](./snacks.md).

## Requirements

Install these before expecting the plugin to work:

- [`opencode` CLI](https://opencode.ai/docs) available on your `PATH`
- [Neovim 0.12+](https://neovim.io/doc/install/)

## Config Location

- Plugin spec: [`lua/plugins/opencode.lua`](../lua/plugins/opencode.lua)
- Snacks integration: [`lua/plugins/snacks.lua`](../lua/plugins/snacks.lua)
- Lazy bootstrap: [`lua/config/lazy.lua`](../lua/config/lazy.lua)

## Mappings

- `<leader>oa`: ask OpenCode about the current selection or cursor context
- `<leader>oo`: open the OpenCode actions picker
- `<leader>ot`: toggle the OpenCode terminal/session

Inside the Snacks picker, `<A-a>` sends the selected item to OpenCode.

Leader is set in [`lua/config/keybinds.lua`](../lua/config/keybinds.lua).

## Verification

After installing or updating plugins:

- run `:Lazy sync`
- run `:checkhealth opencode`

## Upstream References

- [`opencode.nvim` README](https://github.com/nickjvandyke/opencode.nvim)
- [OpenCode documentation](https://opencode.ai/docs)
- [`snacks.nvim` README](https://github.com/folke/snacks.nvim)
