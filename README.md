# Neovim Config

Neovim configuration managed with [`lazy.nvim`](https://github.com/folke/lazy.nvim).

## System Dependencies

Install these before expecting the config to work fully.

### Required

- [`git`](https://git-scm.com/downloads)
- [Neovim 0.12+](https://neovim.io/doc/install/)
- [`ripgrep`](https://github.com/BurntSushi/ripgrep#installation) for Telescope live grep
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads) for patched terminal glyphs and icons

### Required for OpenCode

- [`opencode` CLI](https://opencode.ai/docs) available on your `PATH`

## Important Files

- [`lua/config/lazy.lua`](./lua/config/lazy.lua): bootstraps `lazy.nvim` and loads plugin specs
- [`lua/plugins/opencode.lua`](./lua/plugins/opencode.lua): `opencode.nvim` plugin configuration
- [`lua/plugins/snacks.lua`](./lua/plugins/snacks.lua): `snacks.nvim` configuration for OpenCode enhancements
- [`docs/opencode.md`](./docs/opencode.md): OpenCode usage, mappings, and verification notes
- [`docs/snacks.md`](./docs/snacks.md): Snacks integration details and verification notes

## OpenCode

This config depends on [`opencode.nvim`](https://github.com/nickjvandyke/opencode.nvim) for Neovim integration with [OpenCode](https://opencode.ai/docs).

It also uses [`snacks.nvim`](https://github.com/folke/snacks.nvim) to enhance OpenCode input and picker flows.

See [`docs/opencode.md`](./docs/opencode.md) for:

- required prerequisites
- key mappings
- config locations
- post-install verification steps

See [`docs/snacks.md`](./docs/snacks.md) for:

- Snacks prerequisites
- enabled modules in this config
- OpenCode-specific Snacks integration details
