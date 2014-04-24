execute pathogen#infect()
execute pathogen#helptags()

set laststatus=2 "always show statusbar
set autoindent "Automatically indent to previous indent
set autowrite " write file automatically
set nocompatible " Use Vim defaults - much better
set tabstop=2 "Tab is 4 spaces
set shiftwidth=2 "Indent is 2 spaces
set expandtab "We don't use tabs
set ruler "Show current cursor position
set nohlsearch "don't highlight matching search results
set incsearch "Incremental searching
set ignorecase "Ignore case in searching ...
set smartcase " ... but not if you type capitals
set wildmode=longest,list "Bash style autocomplete: complete longest common string, on second tab give list
set scrolloff=3 "Keep n lines of context around the cursor
set gdefault "default to /g on replacements (everything on a line, instead of just once)
set viminfo+=! "Nonempty viminfo, so viminfo file is kept with scrollpos etc.
set title "Show filename in title bar
set showmatch "Show matching braces when typed
set textwidth=70 "Reasonable width for most text
set formatoptions=cq "Format comments to textwidth, allow gq
set backspace=indent,eol,start "Allow backspace over autoindent, end-of-line and past where insert started.
set cursorline "underline the current active line
set autoread "automatically read changed files if not changed in vim.
syntax enable "enable syntax highlighting
" let g:solarized_termcolors=256
set background=light
" Show trailing spaces and show tabs.
set list
set listchars=tab:>-,trail:·,extends:>,precedes:<,nbsp:.
" Show when a line has been wrapped.
let &showbreak = '↳ '
" colorscheme darkblue
" set bs=2 " allow backspacing over everything in insert mode
" set tw=78 " always limit the width of text to 78
set colorcolumn=100 "show colored column at 100 characters, to prevent too wide text.
let mapleader=' '

" Haskell comments, add . and ' to iskeyword, for hothasktags
autocmd BufRead *.hs,*.lhs setlocal com+=:-- iskeyword=@,48-57,_,192-255,.,39

" set backup " don't keep a backup file
" set viminfo='20,\"50 " read/write a .viminfo file, don't store more
" than 50 lines of registers


" Don't use Ex mode, use Q for formatting
map Q gq
" Make with F12
map <F12> :make<CR><CR>
" Call make with F11 (useful for lhs)
map <F11> :!make<CR>
" Open a file through TextMate like search in a new tab
map <F3> :tabe<CR>:FF<CR>

" Generate tags for haskell, and initialize the find file cache.
map <F4> :!gen_hasktags.sh<CR><CR>
" Mapping to open tag in new tab.
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For *.c and *.h files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  " autocmd BufRead *       set formatoptions=tcql nocindent comments&
  autocmd BufRead *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
augroup END

"augroup gzip
"  " Remove all gzip autocommands
"  au!
"
"  " Enable editing of gzipped files
"  "   read: set binary mode before reading the file
"  "         uncompress text in buffer after reading
"  "  write: compress file after writing
"  " append: uncompress file, append, compress file
"  autocmd BufReadPre,FileReadPre   *.gz set bin
"  autocmd BufReadPost,FileReadPost *.gz '[,']!gunzip
"  autocmd BufReadPost,FileReadPost *.gz set nobin
"  autocmd BufReadPost,FileReadPost *.gz execute ":doautocmd BufReadPost " . %:r
"
"  autocmd BufWritePost,FileWritePost *.gz !mv <afile> <afile>:r
"  autocmd BufWritePost,FileWritePost *.gz !gzip <afile>:r
"
"  autocmd FileAppendPre  *.gz !gunzip <afile>
"  autocmd FileAppendPre  *.gz !mv <afile>:r <afile>
"  autocmd FileAppendPost *.gz !mv <afile> <afile>:r
"  autocmd FileAppendPost *.gz !gzip <afile>:r
"augroup END

" Function to allow tab completion, but also insertion of tabs.
function InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction 
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"swap ' and `, since ` is more useful but far away.
nnoremap ' `
nnoremap ` '
"set compiler for haskellmode.
" au BufEnter *.hs  compiler ghc
" au BufEnter *.lhs compiler ghc
filetype plugin on
"haddock-browser for haskellmode.
" let g:haddock_browser = "open"
" let g:haddock_browser_callformat = "%s %s"
"remove eol whitespace before saving (with complicated expression in
"order to keep the current search term active).
" au FileType haskell,lhaskell,javascript au BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
"change dir to directory of the current file.
map ,cd :cd %:p:h <CR>
"edit a file in the directory of the current file.
map ,e :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Select current () block.
map <buffer> ]' [(v%o
" Remove current () block.
map <buffer> ]] ma[(mb%x'bx'ah
" Create new () block.
map <buffer> ]s <Esc>`>a)<Esc>`<i(<Esc>
" Make do-block of visual selection.
map <buffer> ]d ^<C-V>o^I   <Esc>Rdo<Esc>

" Turn off toolbar in gui
if has("gui_running")
  set guioptions=egmrt
  set guifont=Menlo\ Regular:h12
  colorscheme solarized
  set lines=55 columns=160
endif
" Turn off blinking cursor in non-insert modes.
let &guicursor = substitute(&guicursor, 'n-v-c:', '&blinkon0-', '')
" Have yank and paste use the system clipboard.
set clipboard=unnamed

"------------------------------------------------------------
" CtrlP
"------------------------------------------------------------
" Set the max files
let g:ctrlp_max_files = 10000
let g:ctrlp_cmd = 'CtrlPMixed'

" Optimize file searching
if has("unix")
    let g:ctrlp_user_command = {
                \ 'types': {
                \ 1: ['.git/', 'cd %s && git ls-files']
                \ },
                \ 'fallback': 'find %s -type f | head -' . g:ctrlp_max_files
                \ }
endif
