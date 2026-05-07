# Scala Debugging

This config uses [`nvim-metals`](https://github.com/scalameta/nvim-metals) with [`nvim-dap`](https://github.com/mfussenegger/nvim-dap) to run, test, and debug Scala code.

## Requirements

Install these before expecting Scala debugging to work:

- [Neovim 0.11+](https://neovim.io/doc/install/)
- [Coursier](https://get-coursier.io/docs/cli-installation)
- [sbt](https://www.scala-sbt.org/download/)
- a Scala project that Metals can import

For the local `~/service-billing-7967` project specifically:

- `sbt-bloop` is already enabled in [`project/metals.sbt`](file:///Users/mario.flores/service-billing-7967/project/metals.sbt)
- the service project exposes a forked JVM debug port on `8000` in [`service/build.sbt`](file:///Users/mario.flores/service-billing-7967/service/build.sbt)

## Config Location

- Metals plugin setup: [`lua/plugins/metals.lua`](../lua/plugins/metals.lua)
- DAP setup: [`lua/plugins/dap.lua`](../lua/plugins/dap.lua)

## Current Local Tooling

Based on the current local machine state:

- `cs` is available
- `sbt` is available

## How Debugging Works

Metals configures the Scala debug adapter through `nvim-dap`.

There are two main workflows:

- use Metals code lenses on `main` methods and test classes to run or debug directly from the buffer
- use standard DAP mappings like `<F5>` to start one of the configured Scala debug profiles

## Configured Scala DAP Profiles

The following profiles are configured in [`lua/plugins/dap.lua`](../lua/plugins/dap.lua):

- `Run or Test File`: lets Metals decide whether to run a main method or tests from the current file
- `Test Target`: runs tests for the current build target
- `Run Target`: runs the current build target
- `Attach to service-billing :8000`: attaches to the forked JVM used by `~/service-billing-7967/service`

The attach profile matches this existing sbt config in the project:

- host: `localhost`
- port: `8000`
- build target: `billing-service`

## Metals Mappings

- `<leader>mr`: run the Metals code lens under the cursor
- `<leader>ms`: select a test suite through Metals
- `<leader>mt`: select a test case through Metals

## Shared DAP Mappings

- `<F5>`: continue / start debugger
- `<F10>`: step over
- `<F11>`: step into
- `<F12>`: step out
- `<leader>db`: toggle breakpoint
- `<leader>dc`: run to cursor
- `<leader>du`: toggle DAP UI

## service-billing-7967 Notes

This project already contains the pieces Metals expects:

- multi-module sbt build
- Bloop support through `sbt-bloop`
- Scala test sources that Metals can expose through code lenses
- a JVM attach port for the `billing-service` module

For the attach workflow, start the service the way you normally do through sbt so the JVM is listening on port `8000`, then use the `Attach to service-billing :8000` DAP configuration.

## Verification

- open a Scala file in a Metals-enabled project
- wait for Metals to finish importing
- confirm code lenses appear on mains or tests
- run `:lua print(vim.inspect(require("dap").configurations.scala))`
- start a debug session with `<F5>` or a code lens

## Upstream References

- [`nvim-metals`](https://github.com/scalameta/nvim-metals)
- [`nvim-metals` help](https://github.com/scalameta/nvim-metals/blob/main/doc/metals.txt)
- [Metals debug adapter docs](https://scalameta.org/metals/docs/integrations/debug-adapter-protocol.html)
- [`nvim-dap`](https://github.com/mfussenegger/nvim-dap)
