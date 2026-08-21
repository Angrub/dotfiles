return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Buscar archivos" },
		{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Buscar texto" },
		{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
		{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Archivos recientes" },
		{ "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Ayuda" },
		{ "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
		{ "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Diagnósticos" },
		{ "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Reabrir última búsqueda" },
		{ "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Buscar palabra bajo cursor" },
	},
	opts = {
		"default-title",
		files = {
			cwd_prompt = false,
			git_icons = false,
		},
		grep = {
			rg_glob = true, -- permite `patrón -- *.ts` dentro de la búsqueda
		},
	},
	config = function(_, opts)
		local fzf = require("fzf-lua")
		fzf.setup(opts)
		fzf.register_ui_select()
	end,
}
