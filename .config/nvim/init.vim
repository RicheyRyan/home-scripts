call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'neomake/neomake'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'airblade/vim-gitgutter'
Plug 'mxw/vim-jsx'
Plug 'helino/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/html5.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'kien/rainbow_parentheses.vim'
Plug 'justinmk/vim-sneak'
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" Non web plugins
Plug 'rust-lang/rust.vim'
call plug#end()

" # Configure Basic Editor Options
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=light " or dark
colorscheme solarized
syntax on
set number
set gdefault
set incsearch
set showmatch
set hlsearch
set colorcolumn=100
set textwidth=100
set clipboard=unnamed
set history=1000 " Store lots of :cmdline history
set autoread
set nowrap
filetype plugin on

" Tabs and extra whitespace are evil, so let's highlight them with some fun characters.
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" I like to see the line on which the cursor sits to be highlighted so it is easier to locate.
set cursorline

" The `smartindent` option has Vim use intelligent rules to determine when and how much to indent.
" This is very handy when editing code or bulleted lists.
set smartindent

" As a general rule, I prefer spaces instead of tabs. The following options expand tab keypresses to
" four spaces. I also set tabs to present themselves as four spaces for those files that require
" tabs (like a Makefile).
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" This tells Vim to automatically change the global current working directory to the directory of
" the file currently being edited.
set autochdir

" Further, when working with source code, we ask Vim to support OmniCompletion, which uses smarter
" algorithms to look at the text prior to the cursor to try to guess what you want to type next.
set ofu=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
set wildmode=list:longest,list:full  " Tab completion
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,*/nimcache/*
set wildignore+=*.swp,*~,._*

" For the completion menu, we want on invocation for Vim to insert the longest sequence of letters
" common to all completions, just like in an IDE like Eclipse or NetBeans. Further, we want the menu
" to show even if there was only a single match.
set completeopt=longest,menuone

" Now we want Vim to behave like other editors with regard to open files; by setting this option,
" Vim allows us to have edited buffers "hidden" behind the current one.
set hidden

" Vim usually sets up its handling of keys like `Ctrl-Left` and `Ctrl-Right`, but when `$TERM` is
" set to anything starting with `screen`, it skips this process. To account for my custom `urxvt`
" and `tmux` configurations, I set up this handling myself.
if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" Keybindings
let mapleader="\<Space>"

nnoremap <Leader>w :w<CR>

" Should I make changes to my Vim configuration, it sucks to have to close out and reload, so here's
" a shortcut to reload my configuration.
nnoremap <Leader>rc :source $MYVIMRC<CR>

" CTRL P mappings
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>bl :buffers<CR>
let g:ctrlp_show_hidden = 1

" Windows
nnoremap <Leader>nw :vnew<CR>
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>l <C-W><C-L>
nnoremap <Leader>h <C-W><C-H>

fun! <SID>formatBuffer()
  let l = line(".")
  let c = col(".")
  " Format buffer
  normal ggVG=
  " Strip whitespace
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd BufWritePre * %s/\s\+$//e

" format the entire file
nnoremap <leader>f :call <SID>formatBuffer()<CR>
autocmd BufWritePre * :retab :call <SID>formatBuffer()

" Plug related keybindings
nnoremap <Leader>pu :PlugUpdate<CR>
nnoremap <leader>pU :PlugUpgrade<cr>
nnoremap <leader>pr :UpdateRemotePlugins<cr>
nnoremap <Leader>pc :PlugClean<CR>


" ES6 Stuff
let g:jsx_pragma_required=0
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
au BufRead,BufNewFile *.es6 set filetype=javascript

" Use deoplete.
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Rust settings
let g:rustfmt_autosave = 1

autocmd! BufWritePost * Neomake

" NERDCommenter stuff
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
