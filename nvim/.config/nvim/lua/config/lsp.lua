vim.diagnostic.config({
	virtual_text = { current_line = true },
	severity_sort = true,
	float = { border = "rounded", source = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
})

vim.lsp.enable({ "rust_analyzer" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf
		local map = function(keys, rhs, desc)
			vim.keymap.set("n", keys, rhs, { buffer = buf, desc = "LSP: " .. desc })
		end

		map("gd", "<cmd>FzfLua lsp_definitions<cr>", "Go to definition")
		map("gD", vim.lsp.buf.declaration, "Go to declaration")
		map("grr", "<cmd>FzfLua lsp_references<cr>", "References")
		map("gO", "<cmd>FzfLua lsp_document_symbols<cr>", "Document symbols")
	end,
})
