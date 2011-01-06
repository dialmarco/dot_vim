" Remove the menu bar
if has("gui_running")
        set guioptions-=T
  set guioptions-=r
  set guioptions-=L
endif 

filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype plugin indent on
filetype plugin on

runtime macros/matchit.vim

set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set number

map <C-Up> :buffer 
map <C-Down> :bd<CR> "buffer delete
map <C-Left> :bn<CR> "buffer next
map <C-Right> :bp<CR> "buffer prev
map <D-O> :FuzzyFinderTextMate<CR> 
map <D-R> :NERDTree<CR>
" Make double semi coln escape from insert mode
imap ;; <Esc>

inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction


