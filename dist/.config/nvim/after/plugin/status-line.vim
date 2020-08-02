let g:lightline = {}

let g:lightline.colorscheme = 'nord'

let g:lightline.active = {
      \ 'left': [
      \   [ 'mode', 'paste' ],
      \   [ 'filename', 'readonly', 'modified' ]
      \ ],
      \ 'right': [
      \   [ 'filetype' ],
      \ ]
      \}

" Tabline

let g:lightline.tabline = {
      \ 'left': [['buffers']],
      \ 'right': []
      \}

let g:lightline.component_expand = {
      \ 'buffers': 'lightline#bufferline#buffers',
      \}

let g:lightline.component_type = {
      \ 'buffers': 'tabsel',
      \}
