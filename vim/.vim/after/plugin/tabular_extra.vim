" after/plugin/my_tabular_commands.vim
" Provides extra :Tabularize commands

if !exists(':Tabularize')
  finish " Give up here; the Tabular plugin musn't have been loaded
endif

AddTabularPipeline! multiple_spaces / \{2,}/
      \ map(a:lines, "substitute(v:val, ' \{2,}', '  ', 'g')")
      \   | tabular#TabularizeStrings(a:lines, '  ', 'l0')
