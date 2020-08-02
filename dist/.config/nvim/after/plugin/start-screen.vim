" startify options
let g:startify_session_dir = '~/.local/share/vim-startify/session'

" when opening a file or bookmark,
" seek and change to the root directory of the VCS (if there is one).
let g:startify_change_to_vcs_root = 1

let g:startify_files_number = 10

" Header and footer
let g:startify_custom_header = ''
let g:startify_custom_footer = ''

let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
