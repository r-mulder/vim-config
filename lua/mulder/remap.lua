vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines, keep cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down, center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up, center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result, center" })

vim.keymap.set("n", "<leader>cc", ":CopilotChat<CR>", { noremap = true, silent = true, desc = "Open CopilotChat" })
-- leap.nvim
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)", { desc = "Leap forward" })
vim.keymap.set("n", "S", "<Plug>(leap-from-window)", { desc = "Leap from window" })
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Escape insert mode" })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<c-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>", { desc = "Tmux sessionizer" })

-- Quickfix navigation
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev quickfix item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev location list item" })

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "Insert Go error block" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- split windows
vim.keymap.set("n", "<leader>hs", ":split<Return>", { desc = "Split window horizontal" })
vim.keymap.set("n", "<leader>vs", ":vsplit<Return>", { desc = "Split window vertical" })

-- move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- save with ctrl+s
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Clear and close quickfix list
function ClearQuickFixList()
	vim.fn.setqflist({})
	vim.cmd("cclose")
end

vim.api.nvim_create_user_command("ClearQuickFixList", ClearQuickFixList, {})

vim.keymap.set("n", "<leader>cq", ":ClearQuickFixList<CR>", { noremap = true, desc = "Clear quickfix list" })

-- Lazygit
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Lsp
local lsp_opts = { noremap = true, silent = true }

vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", lsp_opts, { desc = "Go to definition" }))
vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", lsp_opts, { desc = "Hover docs" }))
vim.keymap.set(
	"n",
	"<leader>vws",
	vim.lsp.buf.workspace_symbol,
	vim.tbl_extend("force", lsp_opts, { desc = "Workspace symbol" })
)
vim.keymap.set(
	"n",
	"<leader>vd",
	vim.diagnostic.open_float,
	vim.tbl_extend("force", lsp_opts, { desc = "Diagnostics float" })
)
vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, vim.tbl_extend("force", lsp_opts, { desc = "Code action" }))
vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, vim.tbl_extend("force", lsp_opts, { desc = "References" }))
vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, vim.tbl_extend("force", lsp_opts, { desc = "Rename symbol" }))
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, vim.tbl_extend("force", lsp_opts, { desc = "Signature help" }))
vim.keymap.set("n", "[d", vim.diagnostic.goto_next, vim.tbl_extend("force", lsp_opts, { desc = "Next diagnostic" }))
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, vim.tbl_extend("force", lsp_opts, { desc = "Prev diagnostic" }))
