vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{
		src = "https://github.com/saghen/blink.cmp",
		version = "v1",
	},
	{ src = "https://github.com/stevearc/conform.nvim" },
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "stylua", "rust_analyzer" },
})

require("blink.cmp").setup({
	keymap = { preset = "enter" },
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
	},
	signature = { enabled = true },
	fuzzy = {
		implementation = "lua",
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
		--vim.lsp.buf.format({ async = false })
	end,
})

vim.cmd.colorscheme("kanagawa-dragon")
