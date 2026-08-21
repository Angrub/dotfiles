return {
	{
		"mason-org/mason.nvim",
		opts = { max_concurrent_installers = 2 },
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		opts = {
			ensure_installed = {
				-- servers
				"lua_ls",
				"ts_ls",
				"jsonls",
				"yamlls",
				"html",
				"cssls",
				"tailwindcss",
				"bashls",
				"dockerls",
				"docker_compose_language_service",
				"clangd",
				"gopls",
				"basedpyright",
				"ruff",
				"marksman",
				"vimls",
				-- tools
				"biome",
				"stylua"
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
