return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
		"j-hui/fidget.nvim",
	},

	config = function()
		-- Global capabilities: applies to all servers
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		-- vtsls: overlay custom settings + inlay hints on top of nvim-lspconfig's built-in def
		vim.lsp.config("vtsls", {
			settings = {
				typescript = {
					inlayHints = {
						parameterNames = { enabled = "all" },
						parameterTypes = { enabled = true },
						variableTypes = { enabled = true },
						propertyDeclarationTypes = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						enumMemberValues = { enabled = true },
					},
					suggest = {
						completeFunctionCalls = true,
					},
					updateImportsOnFileMove = { enabled = "always" },
					preferences = {
						importModuleSpecifier = "non-relative",
					},
				},
				javascript = {
					inlayHints = {
						parameterNames = { enabled = "all" },
						parameterTypes = { enabled = true },
						variableTypes = { enabled = true },
						propertyDeclarationTypes = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						enumMemberValues = { enabled = true },
					},
					suggest = {
						completeFunctionCalls = true,
					},
					updateImportsOnFileMove = { enabled = "always" },
				},
			},
			on_attach = function(client, bufnr)
				vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })

				-- Toggle inlay hints
				vim.keymap.set("n", "<leader>ih", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
				end, { buffer = bufnr, desc = "Toggle inlay hints" })
			end,
		})

		-- lua_ls: Neovim-aware workspace config (JIT runtime + nvim API awareness)
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				-- Only apply when there's no project-local .luarc.json
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end
				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
					runtime = {
						version = "LuaJIT",
						path = { "lua/?.lua", "lua/?/init.lua" },
					},
					workspace = {
						checkThirdParty = false,
						library = { vim.env.VIMRUNTIME },
					},
				})
			end,
			settings = { Lua = {} },
		})

		require("fidget").setup({})
		require("mason").setup()
		-- mason-lspconfig automatically calls vim.lsp.enable() for all installed servers
		require("mason-lspconfig").setup({
			ensure_installed = {
				"biome",
				"lua_ls",
				"eslint",
				"html",
				"vtsls",
			},
		})

		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
