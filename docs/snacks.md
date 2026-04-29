# Snacks

This config uses [`snacks.nvim`](https://github.com/folke/snacks.nvim) to enhance the OpenCode workflow with a better input UI and picker integration.

## Requirements

Install these before expecting the plugin to work:

- [Neovim 0.9.4+](https://neovim.io/doc/install/)
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads) for the best icon support

This config already includes [`nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons), which `snacks.nvim` can use for icons.

## Config Location

- Plugin spec: [`lua/plugins/snacks.lua`](../lua/plugins/snacks.lua)
- OpenCode integration: [`lua/plugins/opencode.lua`](../lua/plugins/opencode.lua)

## Enabled Modules

This setup enables only the parts that improve OpenCode directly:

- `input`: enhances `vim.ui.input`, which improves `opencode.ask()`
- `picker`: enhances selection UIs, which improves `opencode.select()`

## OpenCode Integration

With `snacks.nvim` enabled:

- OpenCode prompts use the enhanced Snacks input UI
- OpenCode actions use the Snacks picker UI
- inside the picker, `<A-a>` sends the selected item to OpenCode

See [`docs/opencode.md`](./opencode.md) for the main OpenCode mappings.

## Verification

- run `:Lazy sync`
- run `:checkhealth snacks`
- run `:checkhealth opencode`

## Upstream References

- [`snacks.nvim` README](https://github.com/folke/snacks.nvim)
- [`snacks.nvim` terminal docs](https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md)
- [`snacks.nvim` input docs](https://github.com/folke/snacks.nvim/blob/main/docs/input.md)
- [`snacks.nvim` picker docs](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)
