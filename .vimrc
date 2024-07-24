set modelines=1
" Colors
colorscheme badwolf

" Spaces & Tabs
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

" Go
autocmd FileType go setlocal ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
autocmd FileType go set number

" Rust
autocmd FileType rs setlocal ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
autocmd FileType rs set number

" Yaml specific
autocmd BufNewFile,BufRead,BufFilePre, *.yaml,*.toml set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab autoindent fileformat=unix
autocmd FileType yaml set number

" XSD specific
autocmd FileType xsd setlocal ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
autocmd FileType xsd set number

" XML specific
autocmd FileType xml setlocal ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
autocmd FileType xml set number

" JSON specific
autocmd FileType json setlocal ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
autocmd FileType json set number

" JavaScript specific
autocmd BufNewFile,BufRead,BufFilePre, *.js,*.ts set filetype=javascript
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab autoindent fileformat=unix
autocmd FileType javascript set number

" Markdown
autocmd BufNewFile,BufRead,BufFilePre, *.md,*.markdown,*.mdown,*.mkd,*.mdwn,*.md set filetype=markdown
autocmd FileType markdown set number

" Binary/text files
autocmd BufNewFile,BufRead,BufFilePre, *.txt,*.orig,*.dat,*.csv set filetype=misc_file
autocmd FileType misc_file set number

" UI Layout
" set visual bell
set vb

" adds line under the cursor
set cursorline

" shows matching brace
set showmatch

" Visual autocomplete for command menu
set wildmenu

" Searching
" Show the best match so far
set incsearch

" Also switch on hightlighting the last used search patternn
set hlsearch

" Backspace
set backspace=indent,eol,start

" Line Shorcuts
" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

" Quickly replace all tabs with spaces
nnoremap <leader><Space> :%s/<Tab>/  /g<CR>

" Quickly source .vimrc
nnoremap <leader>s :source $MYVIMRC<CR>

" Quickly quit editting without save
nnoremap <leader>q :q!<CR>

" Saves the file (handling the permission-denied error)
cnoremap w!! w !sudo tee % >/dev/null

" Indent entire file according to the definition of tabs
"=======================================================
" Indent and  go to the top
nnoremap gt gg=G
" Indent and stay keep cursor where it currently is
nnoremap gs mmgg=G'm

" Select all text
nnoremap vA ggVG

" Quick save
nmap <S-s> :w<CR>

" Quite all files with saving
nmap <S-a> :wa<CR>

" Quite all files with saving and exit
nmap <S-a> :wqa<CR>

" Yank to end of line
nnoremap Y y$

"Delete to the end of line
nnoremap D d$

" toggle gundo
nnoremap <F5> :GundoToggle<CR>

"set runtimepath^=~/.vim/bundle/ctrlp.vim
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'

" Remove the netrw header
let g:netrw_banner=0

" vimdiff
nnoremap -c [c
nnoremap -m ]c

" Syntastic
" syntax highlighting
syntax on
"syntax enable

" Statusline
function! LinterStatus() abort
   let l:counts = ale#statusline#Count(bufnr(''))
   let l:all_errors = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors
   return l:counts.total == 0 ? '' : printf(
   \ '<< W:%d E:%d >>',
   \ l:all_non_errors,
   \ l:all_errors
   \)
endfunction
" statusline content and spacing
set laststatus=2
set statusline=
set statusline+=\ [
set statusline+=\ %l    	" Line number
set statusline+=\ --
set statusline+=\ %p%%          " percent
set statusline+=\ ]
"set statusline+=\ %{LinterStatus()}
set statusline+=%=              " spaces
set statusline+=%*\[
set statusline+=\ %m		" modified?
set statusline+=\ %f            " filepath
set statusline+=\ --
set statusline+=\ %{strftime(\"%y.%m.%d\ %H:%M\")}	" Display time (a.k.a last time file was saved)
set statusline+=\ ]

hi statusline guibg=Blue ctermfg=144 guifg=Black ctermbg=Black

" Abbreviations
""" C Abbreviations
abbr mcmt /* <CR> *<CR> */<UP>
abbr scmt /**/<Left><Left>
abbr bcmt /**<CR> *<CR> **/<UP>
abbr typds typedef struct {<CR>};<UP><END><Left><Left>
abbr typde typedef enum {<CR>};<UP><END><Left><Left>
abbr #i #include <><Left>
abbr #h #include ""<Left>
abbr #d #define

""" Python Abbreviations
abbr pymain def main():<CR><CR><CR>if __name__ == "__main__":<CR>    main()<UP><UP><UP>
abbr pybcmt """<CR>"""<UP><CR><Left>
abbr pyscmt """"""<Left><Left><Left>

" Tmux
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Misc
" have Vim jump to the last position when reopening a file
if  has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Shift to the next round tab stop.
set shiftround

" Set auto indent spacing.
set shiftwidth=3

" Remove trailing whitespace
"autocmd BufWritePre * %s/\s\+$//e

set wildignore=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*.o,*.gif,*.jpb,*.png,.git,.svn,*.tmp
" vim:foldmethod=marker:foldlevel=0

source /Users/ChristianLoera/.vim/comment_visual_line/comment_visual_line.vim
" Map a key to call the CommentVisualLine function in visual mode
vnoremap <silent> <leader>c :call CommentVisualLine()<CR>

" Bundles
" Plug ( https://github.com/junegunn/vim-plug )
call plug#begin()

" Plug 'klen/python-mode', { 'for': ['python'] }
Plug 'ambv/black'
Plug 'preservim/nerdtree'
Plug 'nvie/vim-flake8'
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
Plug 'davidhalter/jedi-vim'
Plug 'vim-autoformat/vim-autoformat'

call plug#end()

"-=================================================-
" NOTE: This section is commented out since most of
" these bundles need to be installed. They are not
" part of the install.sh script so they need to be
" installed manually.
"-=================================================-

" Rust ( curl https://sh.rustup.rs -sSf | sh )
"-=================================================-
"set hidden
"let g:racer_cmd = "~/.cargo/bin/racer"
"let g:racer_experimental_completer = 1
"let g:racer_insert_paren = 1
"autocmd FileType rust nmap gd <Plug>(rust-def)
"autocmd FileType rust nmap gs <Plug>(rust-def-split)
"autocmd FileType rust nmap gx <Plug>(rust-def-vertical)
"autocmd FileType rust nmap <leader>gd <Plug>(rust-doc)

" Ctrl P ( https://github.com/kien/ctrlp.vim.git )
"-=================================================-
"set runtimepath^=~/.vim/bundle/ctrlp.vim

" Change the default mapping and default command to invoke CtrlP
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'

" Nerd Tree ( https://github.com/scrooloose/nerdtree.git )
"-=================================================-
"set runtimepath+=~/.vim/bundle/nerdtree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinPos = "right"
map <C-o> :NERDTreeToggle<CR>

" Open NERDTree on start and switch to other windows
"autocmd vimenter * NERDTree
"autocmd vimenter * wincmd p

" Start NERDTree. If a file is specified, move the cursor to its window.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Close vim if NERDTree is the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Asynchronous Lint Engine ( https://github.com/w0rp/ale.git )
"-=================================================-
set runtimepath+=~/.vim/bundle/ale
let g:ale_open_list = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Vim multiple cursors ( https://github.com/terryma/vim-multiple-cursors.git )
"-=================================================-
set runtimepath+=~/.vim/bundle/vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<C-m>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Fuzzy Finder ( https://github.com/junegunn/fzf.git )
"-=================================================-
set runtimepath+=~/.fzf
map <C-f> :FZF<CR>

" Gundo ( https://github.com/sjl/gundo.vim.git )
"-=================================================-
set runtimepath+=~/.vim/bundle/gundo.vim
if has('python3')
	let g:gundo_prefer_python3 = 1
endif
nnoremap <F5> :GundoToggle<CR>

" Vim-Indentwise ( https://github.com/jeetsukumaran/vim-indentwise.git )
"-=================================================-
set runtimepath+=~/.vim/bundle/vim-indentwise
map -pl <Plug>(IndentWisePreviousLesserIndent)
map -pe <Plug>(IndentWisePreviousEqualIndent)
map -pg <Plug>(IndentWisePreviousGreaterIndent)
map -nl <Plug>(IndentWiseNextLesserIndent)
map -ne <Plug>(IndentWiseNextEqualIndent)
map -ng <Plug>(IndentWiseNextGreaterIndent)
map -pa <Plug>(IndentWisePreviousAbsoluteIndent)
map -na <Plug>(IndentWiseNextAbsoluteIndent)
map -bb <Plug>(IndentWiseBlockScopeBoundaryBegin)
map -be <Plug>(IndentWiseBlockScopeBoundaryEnd)

map -i <C-v>g<C-a>
map -s <C-v>g<C-x>

" Vim Python Docstring ( https://github.com/pixelneo/vim-python-docstring.git )
"-=================================================-
set runtimepath+=~/.vim/bundle/vim-python-docstring
let g:python_style = 'google'

" Vim Flake8 ( https://github.com/nvie/vim-flake8.git )
"-=================================================-
set runtimepath+=~/.vim/bundle/vim-flake8
map f8 :call flake8#Flake8()<CR>

" Python Black ( Plug )
"-=================================================-
autocmd BufWritePre *.py execute ':Black'

" Vim-ConflictMotions ( Plug )
"-=================================================-
let g:ConflictMotions_ConflictBeginMapping = 'x'
let g:ConflictMotions_ConflictEndMapping = 'X'
let g:ConflictMotions_MarkerMapping = '='

" Jedi-Vim ( Plug: davidhalter/jedi-vim )
let g:jedi#completions_command = "<C-x>"
let g:jedi#documentation_command = "<C-k>"
let g:jedi#show_call_signatures = 0

" Vim Syntastic ( Plug )
"-=================================================-
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0

" Kite ( Plug )
"-=================================================-
" let g:kite_supported_languages = ['python']

" Ropevim ( Plug: python-rope/ropevim )
"-=================================================-
" set runtimepath+=~/.vim/bundle/ropevim/ftplugin/python_ropevim.vim 
" let ropevim_vim_completion=1
" let ropevim_extended_complete=1
" let g:ropevim_autoimport_modules = ["os", \"shutil\"]

if &diff
  " colorscheme evening
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
endif

nnoremap <Left>  :echoe "Left you alone I should, use h"<CR>
nnoremap <Right> :echoe "Right side of dumb town you are, use l"<CR>
nnoremap <Up>    :echoe "Upside down you must be, use k"<CR>
nnoremap <Down>  :echoe "Down the wrong road here partner, use j"<CR>
