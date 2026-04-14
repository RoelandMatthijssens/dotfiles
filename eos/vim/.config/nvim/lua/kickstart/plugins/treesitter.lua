-- Highlight, edit, and navigate code
-- nvim-treesitter v1.0 rewrite: highlight is automatic via Neovim's built-in
-- treesitter support. Parsers are installed via :TSInstall or the install() call below.

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({
        'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
        'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
      })
    end,
  },
}
