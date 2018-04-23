" --------------------------------------------------------------------------------
" basic settings
" --------------------------------------------------------------------------------
"
" reset to vim-defaults
if &compatible      "only if not set before
  set nocompatible  "use vim-defaults instead of vi-defaults (easier, more user friendly)
endif

" display settings
set background=dark "enable for dark terminals
set laststatus=2    "use 2 lines for the status bar
set matchtime=2     "show matching bracket for 0.2 seconds
set nowrap          "deactivate wrapping
set number          "show line numbers
set ruler                "show the cursor position in the status bar
set scrolloff=5     "keep 5 lines above/below cursor when scrolling
set sidescrolloff=5
set showcmd              "show typed command in status bar
set showmatch       "show matching bracket (briefly jump)
set showtabline=2
set title           "show file in titlebar
set wildignore=*.o,*.so,*.obj,*.bak,*.py[co],*~*
set wildmenu        "completion with menu


" editor settings
set ignorecase      "case insensitive searching
set smartcase       "become case sensitive if you type uppercase characters
set smarttab        "make <tab> and <backspace> smarter
set autoindent cindent  "turn on auto/smart indenting
set backspace=indent,eol,start  "allow backspacing over everything in insert mode

set shiftwidth=4    "spaces for autoindents
set tabstop=8       "number of spaces a tab counts for
set expandtab       "turns tabs into spaces
set textwidth=120   "text automatically breaks after 120 chars
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set completeopt+=menuone
set completeopt+=noselect
set completeopt-=preview
"set shortmess+=c

set autochdir       "automatically change working dir to current file dir
set hidden          "remember undo after quitting

set backup          "create backup~ files
set foldmethod=indent
set foldlevel=99
set history=200     "keep 200 lines of command line history
set lazyredraw
set nomousehide
set noswapfile
set ttimeoutlen=50
set ttyfast

set nospell spelllang=en_us
set spellfile=$HOME/.vimwords.en.utf-8.add
set wildmode=list:longest

set undofile
set undodir=$HOME/.vim/undo/
set undolevels=1000
set undoreload=10000

set tags=./tags;/
set t_Co=256

if executable('ag')
    set grepprg=ag\ --vimgrep\ $*
    set grepformat=%f:%l:%c:%m
elseif executable('ack')
    set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor $*
endif

" color settings (if terminal/gui supports it)
if &t_Co > 2 || has("gui_running")
  set hlsearch  "highlight search (very useful!)
  set incsearch "search incrementally (search while typing)
endif

" enable mouse selection if terminal supports it
if has("mouse")
  set mouse=a
endif

if has("autocmd")
  autocmd FileType vim set tabstop=2 shiftwidth=2
  autocmd FileType xml set tabstop=2 shiftwidth=2

  autocmd Bufread,BufNewFile *.sage,*.pyx,*.spyx set filetype=python
  autocmd Bufread,BufNewFile *.cno,*.ctr set filetype=yaml
  autocmd Bufread,BufNewFile *.m,*.oct set filetype=octave

  " Highlight trailing whitespace upon opening files
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=black guibg=black

  " Always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside
  " an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
endif " has("autocmd")

augroup OmniCompletionSetup
  autocmd!
  autocmd FileType c      set omnifunc=ccomplete#Complete
  autocmd FileType cpp    set omnifunc=ccomplete#Complete
  autocmd FileType python set omnifunc=jedi#completions
augroup END

" --------------------------------------------------------------------------------
" plugin configuration
" --------------------------------------------------------------------------------

" vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Project navigation
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'

" Editor enhancements
Plugin 'sjl/gundo.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'Valloric/ListToggle'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

" Appearance
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'

" Completion/inspection
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/syntastic'
Plugin 'lifepillar/vim-mucomplete'

" Language plugins
Plugin 'chrisbra/csv.vim'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'plasticboy/vim-markdown'
Plugin 'derekwyatt/vim-scala'

" Git plugins
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

call vundle#end()

filetype plugin indent on
syntax on


" Project navigation
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = {'file': '\.c$\|\.htm$\|\.html$\|\.js$\|\.kid$\|\.ods$\|\.odt$\|\.png$\|\.xcf$'}
let g:ctrlp_max_files = 0

" Editor enhancements
let g:indentLine_enabled = 0

" Appearance
"
" Completion/inspection
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 2
let g:jedi#smart_auto_mappings = 0

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_python_checkers=['flake8']
"let g:syntastic_python_flake8_args='--max-line-length=120'
let g:syntastic_python_flake8_exec = 'python3'
let g:syntastic_python_flake8_args = ['-m', 'flake8']

let g:mucomplete#enable_auto_at_startup = 1
"let g:mucomplete#chains = {}
"let g:mucomplete#chains.default = ['omni', 'file', 'keyn', 'dict', 'ulti']
"let g:mucomplete#chains.unite = []

" Language plugins
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1

let g:LatexBox_quickfix = 4

" Git plugins
let g:gitgutter_enabled = 0

" --------------------------------------------------------------------------------
" keyboard shortcuts
" --------------------------------------------------------------------------------

" Change the mapleader key.
map <space> <leader>

" Jump to next row in editor instead of next line
map j gj
map k gk

" open tag definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>

nnoremap <silent> <F1> :%s/\s\+$//e<CR>
"Toggle pep8
"nnoremap <silent> <F2> :let g:syntastic_python_checkers=(g:syntastic_python_checkers==['pyflakes'] ? ['pyflakes', 'pep8'] : ['pyflakes']) <CR> :SyntasticCheck <CR>
"nnoremap <silent> <F4> :Gblame<CR>
"nnoremap <silent> <F7> :NERDTreeToggle<CR>
"nnoremap <silent> <F9> :Errors<CR>
"nnoremap <silent> <F10> :lclose<CR>

" Errors
nnoremap <leader>ec :SyntasticCheck <CR>
nnoremap <leader>en :lnext <CR>
nnoremap <leader>er :SyntasticReset <CR>
nnoremap <leader>ep :lprev <CR>
nnoremap <leader>es :let b:syntastic_skip_checks = 1 <CR>

" Breakpoints
nnoremap <leader>ib oimport pudb; pudb.set_trace() #BREAKPOINT<Esc>

" Edit/Source .vimrc
nnoremap <leader>fe :e $MYVIMRC <CR>
nnoremap <leader>fs :source $MYVIMRC <CR>

"Define a toggling function to enable/disable spell checking
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

"Toggle shortcuts
nnoremap <leader>tb :Gblame <CR>
nnoremap <leader>te :SyntasticToggleMode <CR>
nnoremap <leader>tg :GitGutterToggle <CR>
nnoremap <leader>ti :IndentLinesToggle <CR>
let g:lt_location_list_toggle_map = '<leader>tl'
nnoremap <leader>tn :NERDTreeToggle <CR>
set pastetoggle=<leader>tp
let g:lt_quickfix_list_toggle_map = '<leader>tq'
MapToggle <leader>ts spell
nnoremap <leader>tt :TagbarToggle <CR>
nnoremap <leader>tu :GundoToggle <CR>
nnoremap <leader>tw :let &textwidth=(&textwidth==75 ? 120 : 75) <CR>:set textwidth? <CR>

" Clear search results.
nnoremap <CR> :noh <CR><CR>

set noshowmode        "show mode in status bar (insert/replace/...)
colorscheme solarized
