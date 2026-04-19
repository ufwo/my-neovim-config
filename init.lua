---------------------------------------------------------------------
-- GENERAL ----------------------------------------------------------
---------------------------------------------------------------------

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

---------------------------------------------------------------------
-- PLUGINS ----------------------------------------------------------
---------------------------------------------------------------------

vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/stevearc/conform.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = "v1" },
})

---------------------------------------------------------------------
-- COLORSCHEME ------------------------------------------------------
---------------------------------------------------------------------

vim.cmd.colorscheme("kanagawa-dragon")

---------------------------------------------------------------------
-- LSP'S, FORMATTERS, LINTERS ---------------------------------------
---------------------------------------------------------------------

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "stylua", "rust_analyzer" },
})

local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})

---------------------------------------------------------------------
-- AUTOCOMPLETE -----------------------------------------------------
---------------------------------------------------------------------

require("blink.cmp").setup({
	keymap = { preset = "enter" },
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
	},
	signature = { enabled = true },
	fuzzy = { implementation = "lua" },
})
