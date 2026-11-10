return {
  {
    'dhruvasagar/vim-table-mode',
    cmd = { 'TableModeToggle' }, -- lazy load on command
    keys = {
      { '<leader>tt', '<cmd>TableModeToggle<cr>', desc = 'Toggle Table Mode' },
    },
    config = function()
      -- optional settings
      vim.g.table_mode_corner = '|'
      vim.g.table_mode_header_fillchar = '-'
    end,
  },
}
