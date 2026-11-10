-- Custom shortcuts/keybindings
return {
  'shortcuts.lua',
  dir = '~/.config/nvim/lua/custom/plugins/',
  dev = true,
  keys = {
    -- Toggle spellcheck
    {
      '<leader>spell',
      function()
        vim.opt.spell = not vim.opt.spell:get()
        local status = vim.opt.spell:get() and 'enabled' or 'disabled'
        vim.notify('Spell check ' .. status)
      end,
      desc = 'Toggle spell check',
    },
    -- Format JSON with jq
    {
      '<leader>json',
      ":%!jq '.'<CR>",
      desc = 'Format JSON with jq',
    },
    -- Add more shortcuts below:
    -- {
    --   '<leader>example',
    --   function()
    --     -- your code here
    --   end,
    --   desc = 'Example shortcut',
    -- },
  },
}
