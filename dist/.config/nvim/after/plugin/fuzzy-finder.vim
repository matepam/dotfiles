let g:fzf_nvim_statusline = 0

nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
