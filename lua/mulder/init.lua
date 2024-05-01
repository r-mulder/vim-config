if vim.g.vscode then
    return {}
end

require("mulder.set")
require("mulder.remap")
require("mulder.lazy_init")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local MulderGroup = augroup('Mulder', {})

vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme nord")
-- vim.cmd("colorscheme evergarden")

-- autocmd({ "BufWritePre" }, {
--     group = MulderGroup,
--     pattern = "*",
--     command = [[%s/\s\+$//e]],
-- })

-- autocmd({ "BufWritePre" }, {
--     group = MulderGroup,
--     pattern = "*",
--     -- cannot have command and callback, i use callback now for format on save
--     -- command = [[%s/\s\+$//e]],
--     callback = function()
--         vim.lsp.buf.format()
--         if vim.fn.executable('eslint') == 1 then
--             vim.cmd([[EslintFixAll]])
--         end
--     end,
-- })

vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = MulderGroup,
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

autocmd('LspAttach', {
    group = MulderGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>.", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})


require("oil").setup({
    keymaps = {
        ["<CR>"] = "actions.select",
    },
    use_default_keymaps = false,
    view_options = {
        show_hidden = true,
    }
})
