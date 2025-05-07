return {
    "andrewferrier/debugprint.nvim",
    dependencies = {
        "echasnovski/mini.nvim",          -- Needed to enable :ToggleCommentDebugPrints for NeoVim <= 0.9
        "nvim-treesitter/nvim-treesitter" -- Needed to enable treesitter for NeoVim 0.8
    },
    opts = {
        keymaps = {
            normal = {
                plain_below = "g?p",
                plain_above = "g?P",
                variable_below = "<leader>l",
                variable_above = "g?V",
                variable_below_alwaysprompt = nil,
                variable_above_alwaysprompt = nil,
                textobj_below = "g?o",
                textobj_above = "g?O",
                toggle_comment_debug_prints = nil,
                delete_debug_prints = nil,
            },
            visual = {
                variable_below = "g?v",
                variable_above = "g?V",
            },
        },
        commands = {
            toggle_comment_debug_prints = "ToggleCommentDebugPrints",
            delete_debug_prints = "DeleteDebugPrints",
        },
    },
    version = "*"
}
