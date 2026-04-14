return {
  'rest-nvim/rest.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('rest-nvim').setup {
      skip_ssl_verification = false,
      result_split_horizontal = false,
      result_split_in_place = false,
      encode_url = true,
      highlight = {
        enabled = true,
        timeout = 150,
      },
      jump_to_request = false,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,
    }

    -- Add the keymap for <C-b>
    vim.keymap.set('n', '<C-b>', ':Rest run<CR>', {
      noremap = true,
      silent = true,
      desc = 'Run HTTP request under cursor',
    })
  end,
}
