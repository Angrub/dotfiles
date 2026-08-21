return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter").install({
      "lua", "luadoc", "typescript", "tsx", "javascript",
      "json", "jsonc", "yaml", "html", "css", "bash", "fish",
      "sql", "dockerfile", "c", "make", "cpp", "rust", "go",
      "java", "python", "vim", "vimdoc", "markdown",
      "markdown_inline", "regex", "gitcommit", "gitignore", "diff",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
