
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

call plug#begin('~/.config/nvim/plugged')

set spell

set nocompatible
filetype plugin on " Enable filetype-specific settings.
syntax on " Enable syntax highlighting.

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
  set scrolloff=5

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

  augroup markdown
    autocmd!

    autocmd BufNewFile,BufRead *.md set filetype=markdown
    autocmd FileType markdown,mkd,text call Prose()
    autocmd FileType markdown setlocal spell spelllang=en_us
  augroup END

  function! Prose()
    colorscheme pencil
    set background=dark
    call pencil#init()
  endfunction

" }}}

" Store temporary files in ~/.vim/tmp
set viminfo+=n~/.vim/tmp/viminfo
set backupdir=$HOME/.vim/tmp/backup
set dir=$HOME/.vim/tmp/swap
set viewdir=$HOME/.vim/tmp/view
if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p', 0700) | endif
if !isdirectory(&dir)       | call mkdir(&dir, 'p', 0700)       | endif
if !isdirectory(&viewdir)   | call mkdir(&viewdir, 'p', 0700)   | endif

" Persist undo history between Vim sessions.
if has('persistent_undo')
  set undodir=$HOME/.vim/tmp/undo
  if !isdirectory(&undodir) | call mkdir(&undodir, 'p', 0700) | endif
endif

" {{{ General Plugins
  Plug 'reedes/vim-pencil'
  let g:pencil#wrapModeDefault = 'soft'

  Plug 'junegunn/limelight.vim'

  Plug 'reedes/vim-colors-pencil'

  Plug 'niftylettuce/vim-jinja'

  Plug 'plasticboy/vim-markdown'
  let g:vim_markdown_conceal = 2
  let g:vim_markdown_conceal_code_blocks = 0
  let g:vim_markdown_math = 1
  let g:vim_markdown_toml_frontmatter = 1
  let g:vim_markdown_frontmatter = 1
  let g:vim_markdown_frontmatter = 1
  let g:vim_markdown_strikethrough = 1
  let g:vim_markdown_autowrite = 1
  let g:vim_markdown_edit_url_in = 'tab'
  let g:vim_markdown_follow_anchor = 1

  Plug 'benmills/vimux'

" }}}

" {{{ Startupify
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-startify'

  " Don't change to directory when selecting a file
  let g:startify_files_number = 5
  let g:startify_change_to_dir = 0
  let g:startify_custom_header = [ ]
  let g:startify_relative_path = 1
  let g:startify_use_env = 1

  " returns all modified files of the current git repo
  " `2>/dev/null` makes the command fail quietly, so that when we are not
  " in a git repo, the list will be empty
  function! s:gitModified()
      let files = systemlist('git ls-files -m 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction

  " same as above, but show untracked files, honouring .gitignore
  function! s:gitUntracked()
      let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction

  " Custom startup list, only show MRU from current directory/project
  let g:startify_lists = [
  \  { 'type': 'dir',       'header': [ ' Files '. getcwd() ] },
  \  { 'type': 'sessions',  'header': [ ' Sessions' ]       },
  \  { 'type': 'bookmarks', 'header': [ ' Bookmarks' ]      },
  \ { 'type': function('s:gitModified'),  'header': [' Git modified']},
  \ { 'type': function('s:gitUntracked'), 'header': [' Git untracked']},
  \  { 'type': 'commands',  'header': [ ' Commands' ]       },
  \ ]

  let g:startify_commands = [
  \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
  \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
  \ ]

  let g:startify_bookmarks = [
      \ { 'c': '~/.config/nvim/init.vim' },
      \ { 'g': '~/.gitconfig' },
      \ { 'z': '~/.zshrc' }
  \ ]

  autocmd User Startified setlocal cursorline
  nmap <leader>st :Startify<cr>

" }}}


call plug#end()
" }}}

source ~/Development/dotfiles/vim/theme.vim
