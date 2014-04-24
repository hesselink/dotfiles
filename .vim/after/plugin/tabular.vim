if exists(":Tabularize")
  AddTabularPattern depends /\(>=\)\|\(<\)\|\(==\)\|\(&&\)
  AddTabularPattern imports / as /l0l0
  AddTabularPattern records /\(::\)\|\(=\)

  nmap <Leader>ad :Tabularize depends<CR>
  vmap <Leader>ad :Tabularize depends<CR>
  nmap <Leader>ai :Tabularize imports<CR>
  vmap <Leader>ai :Tabularize imports<CR>
  nmap <Leader>ar :Tabularize records<CR>
  vmap <Leader>ar :Tabularize records<CR>
endif

