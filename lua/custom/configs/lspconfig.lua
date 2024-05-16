local config = require("plugins.configs.lspconfig")

local util = require "lspconfig/util"
local on_attach = config.on_attach
local capabilities = config.capabilities
local lspconfig = require("lspconfig")


lspconfig.clangd.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities=capabilities,
})

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  cmd = {"gopls" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      gofumpt = true,
      completeUnimported = true,
      usePlaceholders = true,
    },
  },
})


lspconfig.csharp_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"cs"}
})

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"javascript", "typescript"}
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})


