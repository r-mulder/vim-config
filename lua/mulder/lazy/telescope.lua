return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local actions = require('telescope.actions')
        -- Load extension.
        require("telescope").load_extension("recent_files")

        require('telescope').setup({
            defaults = {
                mapping = {
                    i = {
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
                    }
                }
            }
        })

        function vim.getVisualSelection()
            local current_clipboard_content = vim.fn.getreg('"')

            vim.cmd('noau normal! "vy"')
            local text = vim.fn.getreg('v')
            vim.fn.setreg('v', {})

            vim.fn.setreg('"', current_clipboard_content)

            text = string.gsub(text, "\n", "")
            if #text > 0 then
                return text
            else
                return ''
            end
        end

        local keymap = vim.keymap.set
        local bt = require('telescope.builtin')
        local opts = { noremap = true, silent = true }

        keymap('n', '<space>G', ':Telescope current_buffer_fuzzy_find<cr>', opts)
        keymap('v', '<space>G', function()
            local text = vim.getVisualSelection()
            bt.current_buffer_fuzzy_find({ default_text = text })
        end, opts)

        keymap('n', '<space>g', ':Telescope live_grep<cr>', opts)
        keymap('v', '<space>g', function()
            local text = vim.getVisualSelection()
            bt.grep_string({ search = text })
        end, opts)

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', builtin.grep_string, {})
        vim.keymap.set('n', '<C-p>', builtin.find_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pss', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.keymap.set("n", "<Leader><Leader>",
            [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
            { noremap = true, silent = true })
    end
}
