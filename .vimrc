" Right side of statusline
set laststatus=2
set statusline=
set statusline=%=
set statusline+=%*\[
set statusline+=\ %f
set statusline+=\ %m
set statusline+=\]

" set visual bell
set vb

" set numberline
set nu

filetype on

" syntax highlighting 
syntax on

" Perl Specific
autocmd FileType perl set showmatch
autocmd FileType perl set nu
let perl_extended_vars = 1    "syntax color complex things 


" Python
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab

" C
autocmd FileType c setlocal ts=4 sts=4 sw=4 expandtab

" C++
autocmd FileType cpp setlocal ts=4 sts=4 sw=4 expandtab

" Color scheme
colo peachpuff

" Remove the netrw header
let g:netrw_banner=0

hi Comment ctermfg=129
hi Statusline ctermfg=152
