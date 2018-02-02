" set visual bell
set vb

filetype on

" Perl Specific
autocmd FileType perl set nu
let perl_extended_vars = 1    "syntax color complex things 


" Python
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix encoding=utf-8
let python_highlight_all=1

" Yaml specific
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Color scheme
colo slate

" Flag Whitespace
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.cpp,*.h,*.hpp,*.pl,*.java match BadWhitespace /\s\+$/

" Remove the netrw header
let g:netrw_banner=0


" syntax highlighting 
syntax on

" adds line under the cursor
set cursorline

" shows matching brace
set showmatch
