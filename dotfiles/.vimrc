" :options, to see a discription of all the vi options
" :set all, to see current state of all vi options
" :help vimrc, for more information

" fix backspace
"if &term == "xterm" || &term == "xterm-256color"
"    set t_kb=
"    fixdel
"endif

set background=dark

" sets the width of a tab
set tabstop=4

" sets the width of an autoindent
set shiftwidth=4

" makes a tab a series of spaces
set expandtab

" enables autoindent: keeps the indent of a previous line 
" when starting a new one
set ai

" enables smarttab: makes autoindent expand tab to shiftwidth
" number of spaces
set sta

" do syntax coloring
syntax on

" show title of file in title of terminal
set title

" highlight all matches for the last used search pattern
set hls

" display the current cursor position in the lower right corner
set ruler

" enables smart indenting for code.
" not compatible with paste
set cin

"set paste
" fixes paste so that you can paste lines of indented code.
" not compatible with cin

" numbers lines
set number

" color scheme
"colorscheme dante 
colorscheme dante2
"colorscheme evening
"colorscheme ron
"colorscheme torte
"colorscheme delek
"colorscheme wombat
"colorscheme desert
"colorscheme slate
"colorscheme slate2
"colorscheme darkzen
"colorscheme impact

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    + current
"              | | | | |  |   |      |  |     |       column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer
set laststatus=2


if has("gui_running")
    set guifont=Monospace\ bold\ 10
endif

" spell checking
if version >= 700
    highlight clear SpellBad
    highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
    highlight clear SpellCap
    highlight SpellCap term=underline cterm=underline
    highlight clear SpellRare
    highlight SpellRare term=underline cterm=underline
    highlight clear SpellLocal
    highlight SpellLocal term=underline cterm=underline
endif
map <F5> :setlocal spell! spelllang=en_us<CR>

" paste toggle
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O><F2>
set pastetoggle=<F2>

" tab complete
function InsertTabWrapper()
 let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" real tab in Makefiles
autocmd FileType make setlocal noexpandtab


