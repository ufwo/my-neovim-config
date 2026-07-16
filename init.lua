vim.loader.enable()

vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/stevearc/conform.nvim",
})

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.clipboard = "unnamedplus"

vim.diagnostic.config({ virtual_text = true, update_in_insert = true })

vim.cmd.colorscheme("kanagawa-dragon")

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		-- lsp
		"lua_ls",
		"rust_analyzer",
		-- formatter
		"stylua",
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
	},
	format_on_save = {},
})

vim.o.complete = ".,o"
vim.o.completeopt = "fuzzy,menuone,noselect,popup"
vim.o.pumheight = 7
vim.o.autocomplete = true
