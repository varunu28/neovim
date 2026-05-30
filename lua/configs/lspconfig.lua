-- 1. Grab NvChad's core LSP settings (handlers, diagnostic styling, etc.)
local nv_configs = require "nvchad.configs.lspconfig"

-- 2. Define your active language servers
local servers = { "html", "cssls", "gopls" }

-- 3. Configure and activate them using the modern native Neovim API
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = nv_configs.on_attach,
    on_init = nv_configs.on_init,
    capabilities = nv_configs.capabilities,
  })
  
  -- Explicitly tell Neovim to turn this LSP engine configuration on
  vim.lsp.enable(lsp)
end
