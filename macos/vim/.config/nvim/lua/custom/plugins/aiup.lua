-- AI Unified Process artifact navigation.
-- The server is installed globally as `aiup-lsp` from the aiup-lsp repository.
return {
  {
    'neovim/nvim-lspconfig',
    opts = function()
      vim.lsp.config.aiup = {
        cmd = { 'aiup-lsp', '--stdio' },
        filetypes = { 'markdown', 'plantuml', 'xml' },
        root_markers = { '.aiup.toml', '.git', 'docs' },
      }
      vim.lsp.enable 'aiup'
    end,
  },
}
