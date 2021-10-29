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
