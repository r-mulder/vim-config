return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                variant = "main", -- main, moon or dawn (light)
                styles = {
                    transparent = true,
                }
            })

            -- vim.cmd("colorscheme rose-pine")
        end
    },
}
