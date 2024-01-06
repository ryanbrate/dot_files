" ------
"  building vim from source
" ------
" sudo apt install xorg-server-devel
" make distclean
" ./configure --with-x=yes
" make
" sudo make install

" ------
" some notes on useful keys
" ------
" see definition search for function search, e.g., [ ctrl-i and [i
"c-w}  # opens a new window showing function signature
"gd  # search for token under cursor
":vimgrep /searchfor/g *.py

"qq  # records the next key strokes to the register
"@q  # plays the keystrokes as though normal mode commands
"c-r  # accesses the register, e.g., to paste the contexts of a register ... c-r p 
"
"%s/someword//n  # get number of lines containng 'someword' 
"%s/someword//gn  # get number instances containng 'someword' 

" ------
" behavioural changes -- always first!
" ------
let mapleader = "," 
set cpo-=<  " enable <> notation, see :h <>

" turn off ZZ (as an alternative to :x)
nnoremap Z <Nop>
nnoremap ZZ <Nop>

" nnoremap <space><space> <c-^>

" ------
" where to find python3
" ------
if has('mac')
    let g:python3_host_prog='/usr/bin/python'
else  " linux
    set pythonthreedll=/usr/lib/x86_64-linux-gnu/libpython3.9.so.1.0
endif

" ------
" clipboard
" ------
if has("macunix")
    set clipboard="unnamed"
else
    set clipboard="unnamedplus"
endif

" ------
" syntax
" ------
syntax enable  " turn on syntax highlighting
filetype plugin on

" ------
" search
" ------
set ignorecase  " ignore case when searching  ...
set smartcase  " ... except where uppercase specified
set hlsearch  " persistent highlight of last search
set incsearch  " highligh as you type
set shortmess-=S  "  switch on searh count when searching

" ------
" performance options
" ------
set lazyredraw  " don't update screen during macro exec
set complete -=i  " i.e, don't provide next-word completion based on included

" ------
" rendering options
" ------
set display+=lastline
set encoding=utf-8
set linebreak
set scrolloff=1  " always 1 line below cursor
set sidescrolloff=5  " always 5 cols to right of cursor
set wrap  " enable line wrapping  

" ------
" UI options
" ------
set laststatus=2  " always show status bar
set ruler
set showtabline=2  " always show tab bar
set cursorline  " always highligh cursor line
set mouse=nvi  " enable mouse
set nu rnu 
set showmatch  " highlight matching bracket
set splitbelow
set noerrorbells  " disable sys beep

set termguicolors
colorscheme shine
" set background=light

" ------
"  default code folding
" ------
set foldmethod=indent
set foldnestmax=3  " only 3 levels of fold
set foldlevel=0 

" -----
" misc
" -----
" tab spaces
set tabstop=4

set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smarttab
set backspace=indent,eol,start

" set path=.,  " :find searches current dir only
set path+=**  " :find search into sub-folders
set wildmenu
set wildmode=full
set wildignore+=*.swp,*.bak  " vim
set wildignore+=*.pyc  " python
set wildignore+=*.blg,*.fls,*.bbl,*.aux,*fdb_latexmk,*.pygtex,*.pygstyle  " latex
set wildignore+=*/.git/**/*  " git
set wildignore+=tags  " ctags
set wildignorecase

set autochdir
set autoread
set formatoptions+=j  " delete comment characters when joining files

" ------
" completion
" ------
if has('mac')
    set dictionary+=/usr/share/dict/words
else
    set dictionary+=/usr/share/dict/british-english 
endif 
set spelllang=en_gb  " for spell checking i.e. set spell

" set omnifunc=syntaxcomplete#Complete
set completeopt+=preview,menuone

" ------
" set shell to zsh in mac
" ------
if has('mac')
    set shell=/bin/zsh\ -l
else
    set shell=bash
endif

" ------
" persistent undo settings
" ------
set undofile
set undodir=~/.vim/undodir
if !isdirectory(&undodir)
    call mkdir(&undodir)
endif 

" ------
" open a html link (in browser) with gx
" ------
if has('mac')
    nnoremap gx :call netrw#BrowseX(netrw#GX(),0)<cr>
else
    let g:netrw_browsex_viewer="setsid xdg-open"
endif

" ------
"Gvim font
" ------
if has('gui_running')
    if has('gui_macvim')
        set guifont=Monaco:h13
    endif
endif

" ------
" setup vimgrep for quick <cword> search in current and sub-folders for the
" current filetype
" ------
command! -nargs=* VG exec len(split(<q-args>)) == 0?
    \'vimgrep '.expand("<cword>").' '.'**/*.'.expand('%:e').'<CR>|copen'
    \:
    \'vimgrep '.<q-args>.' '.'**/*.'.expand('%:e').'<CR>|copen'

" ------
" plugins
" ------
call plug#begin()
    Plug 'tpope/vim-commentary'
    Plug 'mbbill/undotree'
    Plug 'ryanbrate/functional.vim'
    Plug 'ryanbrate/developer_documentation.vim'
    Plug 'jremmen/vim-ripgrep'
call plug#end()

" ------
" working with tabs
" ------
nnoremap <Leader>to :tabnew<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>0 0gt
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt

" ------
" vimrc
" ------
nnoremap <Leader>we :e ~/.vimrc<cr>

" ------
" vimscript documentation
" ------
nnoremap <Leader>vf :h builtin<cr>

" ------
" (basic wimwiki replacement shortcuts)
" ------
if has('mac')
    nnoremap <Leader>ww :e ~/My\ Drive/NOTES/index.md<cr>
    nnoremap <Leader>wi :e ~/My\ Drive/NOTES/scratch.md<cr>
else  " linux
    nnoremap <Leader>ww :e ~/Google\ Drive/NOTES/index.md<cr>
    nnoremap <Leader>wi :e ~/Google\ Drive/NOTES/scratch.md<cr>
endif

" ------
" ctags
" ------
function! Tag() abort
    exec "!ctags -R --languages="..&filetype
endfunction
command! Tag call g:Tag()

" ------
" git log
" ------
nnoremap <Leader>gl :!git log --oneline --graph --all --decorate<CR>

"------
" undotree
"------
nnoremap <F5> :UndotreeToggle<CR>

" ------
" easier buffer navigation
" ------
nnoremap gb :buffers<CR>:buffer<Space>

"------
" custom commands
"------

" highlight those words that tend to get miss-typed (near-homophones)
let s:hom = ["its", "it's", 
            \"there", "their", "they're",
            \"your", "you're",
            \"were", "we're", "where", 
            \"who's", "whose",
            \]
command! Hom exec '/\(' . join(s:hom, '\|') . '\)' 

" highlight (likely unintended) repeated consecutive words
command! RepeatedWords /\(\<\w\+\>\)\_s*\<\1\>

" ------
" ------
" custom functions
" ------
" ------

function! g:RunFixers() abort
    """ Run fixer commands of b:fixer_commands (e.g., defined in augroups).
    """
    for l:fixer_command in b:fixer_commands
        exec l:fixer_command
    endfor
endfunction
command! Fix call g:RunFixers()


function! g:ReadInTemplate() abort
    """ Read in file-type specific template.
    """
    exec ':-1read' . b:template
endfunction
command! Template call g:ReadInTemplate()

"---
" filetype-specific settings
"---

augroup FileType *
    au!
    au FileType * match none "clear previous highlighted matches in new buffer
    au FileType * let b:import_patterns = []
augroup End


augroup FileType vim
    au!
    au FileType vim setlocal colorcolumn=80
augroup End


augroup Filetype julia
    au!
    au Filetype julia setlocal colorcolumn=80
    " au FileType julia let b:fixer_commands = [":!julia -e 'using JuliaFormatter;format_file(\"%\")'"]
    au FileType julia let b:fixer_commands = [":!julia --threads=auto -J ~/Projects/JuliaFormatterSysImage/julia_formatter.so -e 'using JuliaFormatter; format_file(\"%\")'"]

    if has('mac')
        au FileType julia let b:template = "~/My\ Drive/Templates/Julia\ Script.jl"
    else
        au FileType julia let b:template = "~/Google\ Drive/Templates/Julia\ Script.jl"
    endif 

    " :DD
    au FileType julia let b:DD_conj = '.'
    au FileType julia let b:DD_permissible_chars = 'a-zA-Z0-9\._'
    au FileType julia let b:DD_import_patterns = [
        \['using\s\+\(\S\+\)\s*:\s*\(\S\+\)', {2:[1, 2]}],
        \]
    au FileType julia let b:DD_call = "!julia -E 'try; using <1>; catch; end; @doc <TOKEN>' | less"

    au FileType julia nnoremap <buffer> <c-]> :Rg<CR>

augroup End


augroup FileType python 
    au!
    
    au FileType python setlocal colorcolumn=80

    " fixers
    au FileType python let b:fixer_commands = [
                \"!black \"%:p\";fg 2>/dev/null",
                \"!isort \"%:p\";fg 2>/dev/null",
                \]

    " read in python template
    if has('mac')
        au FileType python let b:template = "~/My\ Drive/Templates/Python\ Script.py"
    else
        au FileType python let b:template = "~/Google Drive/Templates/Python\ Script.py"
    endif

    " :DD
    au FileType python let b:DD_conj = '.'
    au FileType python let b:DD_permissible_chars = 'a-zA-Z0-9\._'
    au FileType python let b:DD_import_patterns = [
        \['from\s\+\(\S\+\)\s\+import\s\+\(\S\+\)\s\+as\s\+\(\S\+\)', {3:[1,2]}],
        \['from\s\+\(\S\+\)\s\+import\s\+\(\S\+\)\s*,\s*\(\S\+\)\s*,\s*\(\S\+\)', {2:[1,2], 3:[1,3], 4:[1,4]}],
        \['from\s\+\(\S\+\)\s\+import\s\+\(\S\+\)\s*,\s*\(\S\+\)', {2:[1,2], 3:[1,3]}],
        \['from\s\+\(\S\+\)\s\+import\s\+\(\S\+\)', {2:[1, 2]}],
        \['import\s\+\(\S\+\)\s\+as\s\+\(\S\+\)', {2:[1]}],
        \['\(\S\+\)\s*:\s*\([a-zA-Z0-9\.]\+\)', {1:[2]}],
    \]
    au FileType python let b:DD_call = '!python3 -m pydoc <TOKEN>'
    au FileType python nnoremap <buffer> K :DD<CR>

    au FileType python nnoremap <buffer> <c-]> :Rg<CR>
augroup END


augroup FileType json
    au!
    au FileType json let b:fixer_commands = [":%!python3 -m json.tool"]
    " au FileType json setlocal syntax=off
augroup end


augroup FileType markdown
    au!

    au FileType markdown setlocal spell
    au FileType markdown setlocal complete+=k

    " github markdown - render inline equations
    au Filetype markdown command! Render exec 's/\v\$\$(.+)\$\$/<img\ src="https:\/\/render.githubusercontent.com\/render\/math?math=\1"><cr>'

    " pandoc markdown - convert to pdf
    au Filetype markdown command! Convert exec '!pandoc % -f markdown -t pdf -o %:r.pdf -V geometry:margin=1in<cr>'
    
augroup END

" augroup Filetype r
"     au!
"     au FileType r setlocal colorcolumn=80

"     au FileType r setlocal softtabstop=2
"     au FileType r setlocal shiftwidth=2

"     " " fixers
"     " if has('mac')
"     "     au FileType r let b:fixer_commands = [
"     "                 \"!/Library/Frameworks/R.framework/Versions/4.0/Resources/bin/R --slave -e 'library(styler); style_file(\"%:p\")'",
"                       "fg"
"     "                 \]
"     " else
"     "     au FileType r let b:fixer_commands = [
"     "                 \"!R --slave -e 'library(styler); style_file(\"%:p\")'",
"                       "fg"
"     "                 \]
"     " endif

" augroup END
