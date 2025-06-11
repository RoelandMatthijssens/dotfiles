local function win_move(key)
  local cur_win = vim.api.nvim_get_current_win()
  vim.cmd('wincmd ' .. key)

  if cur_win == vim.api.nvim_get_current_win() then
    if key == 'j' or key == 'k' then
      vim.cmd 'wincmd s'
    else
      vim.cmd 'wincmd v'
    end
    vim.cmd('wincmd ' .. key)
  end
end

return {
  'win_move.lua',
  dir = '~/.config/nvim/lua/custom/plugins/',
  dev = true,
  keys = {
    {
      '<C-h>',
      function()
        win_move 'h'
      end,
      silent = true,
    },
    {
      '<C-j>',
      function()
        win_move 'j'
      end,
      silent = true,
    },
    {
      '<C-k>',
      function()
        win_move 'k'
      end,
      silent = true,
    },
    {
      '<C-l>',
      function()
        win_move 'l'
      end,
      silent = true,
    },
  },
}
