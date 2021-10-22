source ~/Development/dotfiles/vim/plugins.vim

set spell

set nocompatible
filetype plugin on " Enable filetype-specific settings.
syntax on " Enable syntax highlighting.

set autoread " detect when a file is changed

set history=1000 " change history to 1000

" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch " highlight search results
set incsearch " set incremental search, like modern browsers

set backspace=indent,eol,start " make backspace behave in a sane manner
set laststatus=1

" Disable recording for now.
map q <Nop>

if has('mouse')
  set mouse=a
endif


" Appearance {{{
  colorscheme nord
  set textwidth=120
  set colorcolumn=120
  set wrap " turn on line wrapping
  set wrapmargin=8 " wrap lines when coming within n characters from side
  set linebreak " set soft wrapping
  set showbreak=↪
  set ttyfast " faster redrawing
  set showcmd " show incomplete commands
  set listchars=trail:.,tab:>-,eol:¬ " Change the invisible characters

  set wildmode=list:longest " complete files like a shell
  set shell=$SHELL

  " Tab control
  set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
  set tabstop=2 " two tab spaces
  set softtabstop=2 " edit as if the tabs are 4 characters wide
  set shiftwidth=2 " number of spaces to use for indent and unindent
  set shiftround " round indent to a multiple of 'shiftwidth'
  set iskeyword+=\- " Autocomplete words with dashes
  set expandtab " Spaces instead of tabs for better cross-editor compatibility
  set autoindent " Keep the indent when creating a new line
  set cindent " Recommended seting for automatic C-style indentation

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
  set scrolloff=8

" }}}

" General Mappings {{{
  " set a map leader for more key combos
  let mapleader = ' '

  inoremap jj <esc>

  " clear highlighted search
  noremap <space> :set hlsearch! hlsearch?<cr>

  " edit ~/.config/nvim/init.vim
  map <leader>ev :e! ~/.config/nvim/init.vim<cr>
" }}}

for f in split(glob('~/Development/dotfiles/vim/languages/*.vim'), '\n')
  exe 'source' f
endfor

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

" {{{ Vim-Pencil
  let g:pencil#wrapModeDefault = 'soft'
" }}}

" {{{ Ctrl+p
  let g:ctrlp_user_command = {
    \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files']
    \ },
    \ 'fallback': 'fd %s'
  \ }
" }}}

" {{{ Startupify
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
      \ { 'g': '~/.gitconfig' }
  \ ]

  autocmd User Startified setlocal cursorline
  nmap <leader>st :Startify<cr>
" }}}

" {{{ Vim-Markdown
  let g:markdown_include_jekyll_support = 0
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
" }}}
