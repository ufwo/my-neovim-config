---------------------------------------------------------------------
-- PLUGINS ----------------------------------------------------------
---------------------------------------------------------------------

vim.pack.add({
	"https://github.com/metalelf0/kintsugi-nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/stevearc/conform.nvim",
})

---------------------------------------------------------------------
-- GENERAL ----------------------------------------------------------
---------------------------------------------------------------------

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.diagnostic.config({ virtual_text = true, update_in_insert = true })

vim.cmd.colorscheme("kintsugi-flared")

---------------------------------------------------------------------
-- LSP'S, FORMATTERS, LINTERS ---------------------------------------
---------------------------------------------------------------------

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		-- lsp

		"lua_ls",
		"vtsls",
		"rust_analyzer",

		-- formatter

		"stylua",
		"oxfmt",

		-- linter

		"oxlint",
	},
})

local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		javascript = { "oxfmt" },
		typescript = { "oxfmt" },
		json = { "oxfmt" },
		jsonc = { "oxfmt" },
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

vim.o.complete = ".,o"
vim.o.completeopt = "fuzzy,menuone,noselect,popup"
vim.o.pumheight = 7
vim.o.autocomplete = true

---------------------------------------------------------------------
-- TELESCOPE --------------------------------------------------------
---------------------------------------------------------------------

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files)
