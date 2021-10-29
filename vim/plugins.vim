" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.config/nvim/plugged')

  Plug 'reedes/vim-pencil'

  Plug 'junegunn/limelight.vim'
  Plug 'ctrlpvim/ctrlp.vim'

  " Colors
  Plug 'reedes/vim-colors-pencil'
  Plug 'arcticicestudio/nord-vim'

  Plug 'niftylettuce/vim-jinja'

  Plug 'plasticboy/vim-markdown'

  Plug 'benmills/vimux'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-startify'
  Plug 'scrooloose/nerdtree'

call plug#end()
