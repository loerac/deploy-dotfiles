" set visual bell
set vb

filetype on

" Bash Specific
"autocmd FileType sh set ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
autocmd FileType sh set nu

" Perl Specific
autocmd FileType perl set ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
autocmd FileType perl set nu
let perl_extended_vars = 1    "syntax color complex things 

" Python
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix encoding=utf-8 
autocmd FileType python set number
let python_highlight_all=1

" C
autocmd FileType c setlocal expandtab autoindent fileformat=unix
autocmd FileType c set number
autocmd FileType c setlocal sts=3 ts=3 sw=3

" C++
autocmd FileType cpp setlocal ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
autocmd FileType cpp set number

" Rust
autocmd FileType rs setlocal ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
autocmd FileType rs set number

" Yaml specific
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab autoindent fileformat=unix
autocmd FileType yaml set number

" XSD
autocmd FileType xsd setlocal ts=2 sts=2 sw=2 expandtab autoindent fileformat=unix
autocmd FileType xsd set number

"Markdown
autocmd BufNewFile,BufRead,BufFilePre, *.md,*.markdown,*.mdown,*.mkd,*.mdwn,*.md set filetype=markdown
autocmd FileType markdown set number

" Remove trailing whitespace
autocmd FileType c,cpp autocmd BufWritePre <buffer> %s/\s\+$//e

" Color scheme
colo darkblue " looks nice with white background

" Remove the netrw header
let g:netrw_banner=0

" syntax highlighting
syntax on

" adds line under the cursor
set cursorline

" shows matching brace
set showmatch

" have Vim jump to the last position when reopening a file
if  has("autocmd")
         au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" ctrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*.o,*.gif,*.jpb,*.png,.git,.svn,*.tmp

""
" Statusline
""
" statusline content and spacing
set laststatus=2
set statusline=
set statusline+=%=              " spaces
set statusline+=%*\[
set statusline+=%m              " modified?
set statusline+=\ %t            " filepath
set statusline+=\ %p%%          " percent
set statusline+=\ %l:%c                " line:column
set statusline+=\]
"set statusline+=\ %{&fileencoding?&fileencoding:&encoding}

" statusline
hi statusline guibg=Blue ctermfg=144 guifg=Black ctermbg=Black
hi Comment ctermfg=LightBlue

noremap <expr> k ((line('.')==1)?'':'k')
noremap <expr> j ((line('.')==line('$'))?'':'j')
