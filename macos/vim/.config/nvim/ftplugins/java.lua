local util = require 'lspconfig.util'
local root = util.root_pattern('pom.xml', 'build.gradle', '.git')(vim.fn.getcwd())
if not root then
  return
end

-- Kill the wrong server if it attached
for _, c in ipairs(vim.lsp.get_active_clients { bufnr = 0 }) do
  if c.name == 'java_language_server' then
    vim.lsp.stop_client(c.id)
  end
end

-- Unique workspace per project
local ws = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. vim.fn.fnamemodify(root, ':p:h:t')
vim.fn.mkdir(ws, 'p')

-- Optional: nvim-cmp caps
local caps = nil
local ok, cmp = pcall(require, 'cmp_nvim_lsp')
if ok then
  caps = cmp.default_capabilities()
end

-- Avoid duplicate jdtls
for _, c in ipairs(vim.lsp.get_clients { name = 'jdtls' }) do
  if c.config.root_dir == root then
    return
  end
end

vim.lsp.start {
  name = 'jdtls',
  cmd = { 'jdtls', '-data', ws },
  root_dir = root,
  capabilities = caps,
}
