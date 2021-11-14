vim.cmd([[
augroup detectfiletypes
  autocmd! BufRead,BufNewFile *.mxx,*.mpp,*.txx,*.tpp setfiletype cpp
augroup END

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.pdc set filetype=markdown.pandoc
augroup END

augroup build2_syntax
    au! BufNewFile,BufFilePre,BufRead buildfile set filetype=make
augroup END

augroup asmfiletypes
  autocmd! BufRead,BufNewFile *.s,*.asm set filetype=asm
augroup END

augroup zigfile
    autocmd! BufRead,BufNewFile *.zig set filetype=zig
augroup END

augroup nixfile
    autocmd! BufRead,BufNewFile *.nix set filetype=nix
augroup END

augroup glsl
    autocmd! BufNewFile,BufRead *.vert,*.tesc,*.tese,*.geom,*.frag,*.comp,*.glsl set ft=glsl
augroup END
]])
