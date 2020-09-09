set spell

set nocompatible

set autoread " detect when a file is changed

set history=1000 " change history to 1000
set textwidth=120

" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch " highlight search results
set incsearch " set incremental search, like modern browsers

set laststatus=1

set tabstop=2

if has('mouse')
  set mouse=a
endif

set backspace=indent,eol,start " make backspace behave in a sane manner

" Appearance {{{
  set wrap " turn on line wrapping
  set wrapmargin=8 " wrap lines when coming within n characters from side
  set linebreak " set soft wrapping
  set showbreak=↪
  set autoindent " automatically set indent of new line
  set ttyfast " faster redrawing
  set showcmd " show incomplete commands
  set wildmode=list:longest " complete files like a shell
  set shell=$SHELL

  " Tab control
  set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
  set tabstop=4 " the visible width of tabs
  set softtabstop=4 " edit as if the tabs are 4 characters wide
  set shiftwidth=4 " number of spaces to use for indent and unindent
  set shiftround " round indent to a multiple of 'shiftwidth'

  " code folding settings
  set foldmethod=syntax " fold based on indent
  set foldlevelstart=99
  set foldnestmax=10 " deepest fold is 10 levels
  set nofoldenable " don't fold by default
  set foldlevel=1

  " toggle invisible characters
  set list
  set listchars=tab:→\ ,trail:⋅,extends:❯,precedes:❮

  set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
  " switch cursor to line when in insert mode, and block when not
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

  set columns=100 " size of the editable area
  set noruler " don't show ruler
  set linebreak " break the lines on words

" }}}

" General Mappings {{{
  " set a map leader for more key combos
  let mapleader = ','

  inoremap jj <esc>

  " clear highlighted search
  noremap <space> :set hlsearch! hlsearch?<cr>

  " edit ~/.config/nvim/init.vim
  map <leader>ev :e! ~/.config/nvim/init.vim<cr>
" }}}

" AutoGroups {{{
  " file type specific settings
  augroup configgroup
      autocmd!

    " automatically resize panes on resize
    autocmd VimResized * exe 'normal! \<c-w>='
    autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
    autocmd BufWritePost .vimrc.local source %

  augroup END
" }}}

source ~/Development/dotfiles/vim/theme.vim