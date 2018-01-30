" set visual bell
set vb

filetype on

" syntax highlighting 
syntax on

" Perl Specific
autocmd FileType perl set showmatch
autocmd FileType perl set nu
let perl_extended_vars = 1    "syntax color complex things 


" Python
autocmd FileType python set nu
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab

" Yaml specific
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Color scheme
colo slate

" Remove the netrw header
let g:netrw_banner=0
