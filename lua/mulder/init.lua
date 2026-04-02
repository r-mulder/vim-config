if vim.g.vscode then
	return {}
end

require("mulder.set")
require("mulder.remap")
require("mulder.lazy_init")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local MulderGroup = augroup("Mulder", {})

vim.o.termguicolors = true

-- colorscheme
vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme everforest")
-- vim.cmd("colorscheme nord")

vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = MulderGroup,
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

autocmd("LspAttach", {
	group = MulderGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
	end,
})

require("oil").setup({
	keymaps = {
		["<CR>"] = "actions.select",
	},
	use_default_keymaps = false,
	view_options = {
		show_hidden = true,
	},
})
