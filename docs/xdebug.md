# Xdebug

This config includes PHP debugging through [`nvim-dap`](https://github.com/mfussenegger/nvim-dap) with the [`vscode-php-debug`](https://github.com/xdebug/vscode-php-debug) adapter.

## Requirements

Install or provide these before expecting PHP debugging to work:

- [PHP](https://www.php.net/downloads.php)
- [Node.js](https://nodejs.org/en/download)
- [Xdebug](https://xdebug.org/docs/install)
- [`vscode-php-debug`](https://github.com/xdebug/vscode-php-debug)

This config expects the PHP debug adapter entrypoint at:

- `~/.local/share/nvim/dap-adapters/vscode-php-debug/out/phpDebug.js`

## Current State

Based on the current local machine state:

- `node` is available
- `php` is available
- the adapter file exists at the configured path
- local CLI `php -m` does not currently show `xdebug`

That means Neovim is configured for PHP debugging, but local CLI debugging will still require Xdebug to be installed and enabled in the PHP runtime you are actually debugging.

## Config Location

- DAP config: [`lua/plugins/dap.lua`](../lua/plugins/dap.lua)
- PHP LSP config: [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua)

## Configured PHP Debug Profiles

### Listen for Xdebug

This profile listens for incoming Xdebug connections on port `9003`.

- name: `Listen for Xdebug`
- host: `0.0.0.0`
- port: `9003`
- path mapping: `"/ebs1/www" -> "${workspaceFolder}"`
- `stopOnEntry = false`

This is the profile to use when PHP is running somewhere else and connects back into Neovim through Xdebug.

### Current PHP File

This profile runs the current file through the local `php` executable.

- name: `Current PHP file`
- program: `${file}`
- cwd: `${workspaceFolder}`
- runtime executable: `php`
- port: `9003`

This profile is useful for local CLI-style debugging, but it still depends on Xdebug being available in the PHP runtime if you expect step debugging behavior.

## Keymaps

- `<F5>`: continue / start debugger
- `<F10>`: step over
- `<F11>`: step into
- `<F12>`: step out
- `<leader>db`: toggle breakpoint
- `<leader>dc`: run to cursor
- `<leader>du`: toggle DAP UI

The DAP UI opens automatically when a debug session starts and closes when it ends.

## PHP Language Support

PHP editor support is configured separately through [`intelephense`](https://intelephense.com/).

See [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua) for the configured PHP LSP setup.

## Verification

- run `:Lazy sync`
- run `:lua print(vim.inspect(require("dap").configurations.php))`
- run `:checkhealth`
- confirm your PHP runtime has Xdebug enabled with `php -m`

## Upstream References

- [`nvim-dap`](https://github.com/mfussenegger/nvim-dap)
- [`nvim-dap-ui`](https://github.com/rcarriga/nvim-dap-ui)
- [`vscode-php-debug`](https://github.com/xdebug/vscode-php-debug)
- [Xdebug documentation](https://xdebug.org/docs)
- [Xdebug step debugging](https://xdebug.org/docs/step_debug)
