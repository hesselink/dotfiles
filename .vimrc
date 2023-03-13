execute pathogen#infect()
execute pathogen#helptags()

" Persist undo history across runs.
set undodir=~/.vim/undofiles/
set undofile

" Store swap and backup files centrally.
set directory=$HOME/.vim/swap//
if !isdirectory(&directory)
  call mkdir(&directory)
endif
set backupdir=$HOME/.vim/backup//
if !isdirectory(&backupdir)
  call mkdir(&backupdir)
endif

" Save cursor position when leaving. BufWinLeave doesn't work when
" closing and reopening tabs without quitting vim.
au BufLeave *.* silent! mkview
au BufEnter *.* silent! loadview

set number "show line numbers
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
" don't redraw screen during macros etc.
set lazyredraw
" Make % matching with with Haskell lambda's like (\(a,b) -> (b,a))
" even though there's a backslash before a parenthesis.
set cpoptions+=M
" Turn off modeline (reading config from first lines of opened file)
set nomodeline

nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>z ZZ
nnoremap <Leader>e :e
nnoremap <Leader>p :CtrlP<CR>

" Haskell comments, add . and ' to iskeyword, for hothasktags
autocmd BufRead *.hs,*.lhs setlocal com+=:-- iskeyword=@,48-57,_,192-255,.,39

" Set less filetype.
autocmd BufRead *.less setlocal ft=less

" set backup " don't keep a backup file
" set viminfo='20,\"50 " read/write a .viminfo file, don't store more
" than 50 lines of registers


" Don't use Ex mode, use Q for formatting
map Q gq
" Yank to end of line with Y, more consistent with D and C.
map Y y$
" Make with F12
map <F12> :make<CR><CR>
" Call make with F11 (useful for lhs)
map <F11> :!make<CR>
" Call stylish to format Haskell.
vmap <F5> :!stylish-haskell<CR>
nmap <F5> :%!stylish-haskell<CR>

" Generate tags for haskell, and initialize the find file cache.
map <F4> :!gen_hasktags.sh<CR><CR>
" Mapping to open tag in new tab.
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" For when you forget to sudo.. really write the file.
cmap w!! w !sudo tee % >/dev/null

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
" function! InsertTabWrapper()
"   let col = col('.') - 1
"   if !col || getline('.')[col - 1] !~ '\k'
"     return "\<tab>"
"   else
"     return "\<c-p>"
"   endif
" endfunction 
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>
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

" Turn off toolbar in gui
if has("gui_running")
  set guioptions=egmrt
  if has("unnamedplus")
    set guioptions+=a
  endif
  set guifont=Menlo\ Regular:h12
  colorscheme solarized
  set lines=55 columns=160
endif
" Turn off blinking cursor in non-insert modes.
let &guicursor = substitute(&guicursor, 'n-v-c:', '&blinkon0-', '')
" Have yank and paste use the system clipboard.
if has("unnamedplus")
  set clipboard=autoselect,unnamedplus
else
  set clipboard=unnamed
endif

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

"------------------------------------------------------------
" Coc
"------------------------------------------------------------

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
" set hidden " disabled, gives 'save' on unmodified tabs on window close, not tab close

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
