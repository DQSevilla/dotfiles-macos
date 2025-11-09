# Snacks Config

Modular configuration for https://github.com/folke/snacks.nvim.

Each file contains the configuration that is relevant to a single snack plugin.

Nvim just merges all these tables into one large one, and so plugin config requires specifying the
plugin name in the opts of each snack. For example:
```lua
return {
    "snacks.nvim",
    opts = {
        -- example: configuring the dashboard snack plugin:
        dashboard = {
            -- opts here ...
        },
    }
}
```
