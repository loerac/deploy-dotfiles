set modelines=1
" Colors {{{
colorscheme badwolf
" }}}
" Spaces & Tabs {{{
" Detect the type of file that is edited
filetype on

" Bash Specific
autocmd FileType sh set ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
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
autocmd FileType c setlocal ts=3 sts=3 sw=3 expandtab autoindent fileformat=unix
autocmd FileType c set number

" C++
autocmd FileType cpp setlocal ts=3 sts=3 sw=3 expandtab autoindent fileformat=unix
autocmd FileType cpp set number

" Rust
autocmd FileType rs setlocal ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
autocmd FileType rs set number

" Yaml specific
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab autoindent fileformat=unix
autocmd FileType yaml set number

" JSON specific
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab autoindent fileformat=unix
autocmd FileType json set number

" Markdown
autocmd BufNewFile,BufRead,BufFilePre, *.md,*.markdown,*.mdown,*.mkd,*.mdwn,*.md set filetype=markdown
autocmd FileType markdown set number
" }}}
" UI Layout {{{
" set visual bell
set vb

" adds line under the cursor
set cursorline

" shows matching brace
set showmatch

" Visual autocomplete for command menu
set wildmenu
" }}}
" Searching {{{
" Show the best match so far
set incsearch

" Also switch on hightlighting the last used search patternn
set hlsearch
" }}}
" Line Shorcuts {{{
" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

" toggle gundo
nnoremap <F5> :GundoToggle<CR>
" }}}
" Line Shorcuts {{{
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Remove the netrw header
let g:netrw_banner=0
" }}}
" Syntastic {{{
" syntax highlighting
"syntax on
syntax enable
" }}}
" Statusline {{{
" statusline content and spacing
set laststatus=2
set statusline=
set statusline+=%=              " spaces
set statusline+=%*\[
set statusline+=%m              " modified?
set statusline+=\ %f            " filepath
set statusline+=\ %p%%          " percent
set statusline+=\]

hi statusline guibg=Blue ctermfg=144 guifg=Black ctermbg=Black
" }}}
" Abbreviations {{{
abbr cmt /* <CR> *<CR>*/<UP>
abbr scmt /**/<Left><Left>
abbr bcmt /**********************************************<CR> *<CR>**********************************************/<UP>
abbr typds typedef struct {<CR>};<UP><END><Left><Left>
abbr typde typedef enum {<CR>};<UP><END><Left><Left>
abbr #i #include <><Left>
abbr #h #include ""<Left>
abbr #d #define
" }}}
" Tmux {{{
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}
" Backups {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}
" Misc {{{
" have Vim jump to the last position when reopening a file
if  has("autocmd")
         au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

set wildignore=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*.o,*.gif,*.jpb,*.png,.git,.svn,*.tmp
" }}}
" vim:foldmethod=marker:foldlevel=0
