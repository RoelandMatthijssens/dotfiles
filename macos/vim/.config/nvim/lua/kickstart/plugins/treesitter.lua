-- Highlight, edit, and navigate code

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main', -- Rewrite branch targeting current/nightly Neovim (incompatible with old `master` API)
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ensure_installed = {
        'bash',
        'c',
        'diff',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
      }

      require('nvim-treesitter').install(ensure_installed)

      -- Enable highlighting and indentation only when a parser is already
      -- installed. Parser installation is asynchronous, so opening a file must
      -- not assume that language.add() made a parser immediately available.
      -- The explicit list above is installed/updated by :TSUpdate.
      local installed = {}
      for _, lang in ipairs(require('nvim-treesitter.config').get_installed()) do
        installed[lang] = true
      end

      -- Enable highlighting and indentation for installed parsers
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          -- Skip plugin UI / non-file buffers (e.g. neo-tree, nui splits, terminals)
          if vim.bo[ev.buf].buftype ~= '' then
            return
          end

          local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
          if not installed[lang] then
            return
          end

          -- Some languages depend on vim's regex highlighting system (such as Ruby)
          -- for indent rules, so keep regex highlighting alongside treesitter for those.
          local use_regex_too = { ruby = true }
          vim.treesitter.start(ev.buf, lang)
          vim.bo[ev.buf].syntax = use_regex_too[lang] and 'on' or vim.bo[ev.buf].syntax

          if lang ~= 'ruby' then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
