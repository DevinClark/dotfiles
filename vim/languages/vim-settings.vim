augroup configgroup
  autocmd!

  " automatically resize panes on resize
  autocmd VimResized * exe 'normal! \<c-w>='
  autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
  autocmd BufWritePost .vimrc.local source %

augroup END
