return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
		{
			"giuxtaposition/blink-cmp-copilot",
			dependencies = { "zbirenbaum/copilot.lua" },
		},
	},

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			-- Match existing muscle memory
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<CR>"]  = { "accept", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
			kind_icons = {
				Copilot      = "",
				Text         = "󰉿",
				Method       = "󰊕",
				Function     = "󰊕",
				Constructor  = "󰒓",
				Field        = "󰜢",
				Variable     = "󰆦",
				Property     = "󰖷",
				Class        = "󱡠",
				Interface    = "󱡠",
				Struct       = "󱡠",
				Module       = "󰅩",
				Unit         = "󰪚",
				Value        = "󰦨",
				Enum         = "󰦨",
				EnumMember   = "󰦨",
				Keyword      = "󰻾",
				Constant     = "󰏿",
				Snippet      = "󱄽",
				Color        = "󰏘",
				File         = "󰈔",
				Reference    = "󰬲",
				Folder       = "󰉋",
				Event        = "󱐋",
				Operator     = "󰪚",
				TypeParameter = "󰬛",
			},
		},

		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			ghost_text = { enabled = true },
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "copilot" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
					transform_items = function(_, items)
						local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
						local kind_idx = #CompletionItemKind + 1
						CompletionItemKind[kind_idx] = "Copilot"
						for _, item in ipairs(items) do
							item.kind = kind_idx
						end
						return items
					end,
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},

	opts_extend = { "sources.default" },
}
