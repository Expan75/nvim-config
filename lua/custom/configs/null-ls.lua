
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local opts = {
  sources = {
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.tidy,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.cppcheck,
    null_ls.builtins.diagnostics.checkmake,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.diagnostics.mlint,
    null_ls.builtins.diagnostics.tidy,
    null_ls.builtins.diagnostics.protoc_gen_lint,
    null_ls.builtins.formatting.csharpier,
    null_ls.builtins.diagnostics.sqlfluff.with({
        extra_args = { "--dialect", "postgres" }, -- change to your dialect
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end
}
return opts
