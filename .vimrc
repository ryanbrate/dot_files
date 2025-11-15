" ------
"  git notes
" ------
"  remove staged changed, but keep changes in working dir
"    git restore --staged <filepath>

"  discard changes in working dir (to last commit), with no affect on staging area
"    git restore <filepath>

"  Note: git add;git restore;git commit; results in the working directory
"  being behind the latest commit. A subsequent git restore will handle this.
"
"  update last commit with latest staged changes
"    git commit --amend

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
"%s/someword//gn  # get number instances containg 'someword' 

":windo diffthis
"do  # diff obtain, i.e., bring changes from other window into current
"c[ or c] to move between diffs

" using UNIX/linux filter: takes input, processes it, and gives output
" https://vimways.org/2019/vim-and-the-shell/
" :r!ls  # read in the output of a command
" :.!sh  # execute current line in terminal and replace with stdoutput
" :.,+1!python3 # execute several lines as python3 code, and replace with stdoutput (BEWARE INDENTS)
" :%!sort  # replace buffer contents with sorted
" :r!sort %  # read in stdout of a sort of the current buffer

" ------
" behavioural changes -- always first!
" ------
let mapleader = "," 
set cpo-=<  " enable <> notation, see :h <>

" turn off ZZ (as an alternative to :x)
nnoremap Z <Nop>
nnoremap ZZ <Nop>

" nnoremap <space><space> <c-^>
nnoremap <space> za

" ------
" clipboard
" ------
if has("macunix")
    set clipboard="unnamed"
else
    set clipboard="unnamedplus"
endif

" ------
" filetype
" ------
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
set complete +=t

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


" ------
"  default code folding and saving/ loading folds
" ------
set foldmethod=indent
set foldcolumn=2
set foldlevel=0

augroup AutoSave
    au BufWrite,VimLeave,BufUnload * silent! mkview
    au BufRead  * silent! loadview
augroup END

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
set path+=**  " :find searches sub-folders recursively
set wildmenu wildoptions=pum
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
" git integration
" ------
nnoremap <C-g>d :Gvdiffsplit<CR>

" in window diff
" ------
nnoremap <C-w>d :windo diffthis<CR>


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

" ------
" set shell to zsh in mac
" ------
if has('mac')
    set shell=/bin/zsh\ -l
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
" :VG [pattern]
" ------
" If [pattern] is omitted, use <cword>.
" Searches recursively; restricts to current buffer's extension if present.
command! -nargs=* VG execute
      \ 'vimgrep /' .
      \ ( empty(<q-args>)
      \     ? escape(expand('<cword>'), '\/')
      \     : escape(<q-args>, '\/') ) .
      \ '/ **/*' .
      \ ( expand('%:e') != '' ? '.' . expand('%:e') : '' )
      \ | copen


" nohls
nnoremap <leader><space> :nohls<CR>

" ------
" plugins
" ------
call plug#begin()
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'mbbill/undotree'
    Plug 'yegappan/lsp'
    " Plug 'github/copilot.vim'
    Plug 'ojroques/vim-oscyank', {'branch': 'main'}
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'morhetz/gruvbox'
    " Plug 'vim-airline/vim-airline'
    Plug 'nordtheme/vim'
call plug#end()

" ------
" fzf
" ------
nnoremap <leader>fu :Files ~/<CR>
nnoremap <leader>fl :Files ./<CR>

" ------
" copilot
" ------
" imap <silent><script><expr> <c-n> copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true

" ------
" lsp
" ------
let lspOpts = #{ 
    \ autoHighlightDiags: v:true,
    \ showSignature: v:true,
    \ showDiagWithFloat: v:true,
\}
autocmd User LspSetup call LspOptionsSet(lspOpts)

"pip install 'python-lsp-server[all]'
let lspServers = [#{
    \ name: 'pylsp',
    \ filetype: 'python',
    \ path: system('which pylsp')[:-2],
    \ args: [],
    \ workspaceConfig: #{
    \   pylsp: #{
    \     plugins: #{
    \       pycodestyle: #{ ignore: ['E501', 'E226', 'W293']},
    \       flake8: #{ enabled: v:false },
    \     }
    \   }
    \ }
 \}]
autocmd User LspSetup call LspAddServer(lspServers)

nnoremap <leader>d :LspDiagShow<CR>
nnoremap <C-]> :LspGoToDefinition<CR>
nnoremap gr :LspShowReference<CR>
nnoremap gR :LspRename<CR>

" ------
" colorscheme
" ------

set termguicolors
let hour = str2nr(strftime("%H"))
if hour > 7 && hour < 19
    colorscheme retrobox
    set background=dark


    " set background=dark
    syntax enable
else
    colorscheme retrobox
    set background=dark
    syntax enable
endif

" ------
" vimrc
" ------
nnoremap <Leader>we :e ~/dot_files/.vimrc<cr>

" ------
" bashrc
" ------
nnoremap <Leader>wz :e ~/.zshrc<cr>

" ------
" vimscript documentation
" ------
nnoremap <Leader>vf :h builtin<cr>

" ------
" (basic wimwiki replacement shortcuts)
" ------
nnoremap <Leader>ww :e ~/scratch.md<cr>

" ------
" custom commands
" ------

" git log
nnoremap <Leader>gl :!git log --oneline --graph --all --decorate<CR>

" undotree
nnoremap <F5> :UndotreeToggle<CR>

" easier buffer navigation
nnoremap gb :buffers<CR>:buffer<Space>

" highlight those words that tend to get miss-typed (near-homophones)
let s:hom = ["its", "it's", 
            \"there", "their", "they're",
            \"your", "you're",
            \"were", "we're", "where", 
            \"who's", "whose",
            \]
command! Hom exec '/\(' .. join(s:hom, '\|') .. '\)'

" highlight (likely unintended) repeated consecutive words
command! RepeatedWords /\(\<\w\+\>\)\_s*\<\1\>

" ------
" ------
" custom functions
" ------
" ------

function! Tag() abort
    exec '!ctags -R --languages='..&filetype
endfunction
command! Tag call g:Tag()

function! g:RunFixers() abort
    """ Run fixer commands of b:fixer_commands (e.g., defined in augroups).
    """
    for l:fixer_command in b:fixer_commands
        exec l:fixer_command
    endfor
endfunction
command! Fix call g:RunFixers()

function! g:SnipNames(ArgLead, CmdLine, CursorPos) abort
    """ Return a customlist for command-complete, of snippet 'names' at b:snippets_dir
    """
    " get snippet fps
    let fps = filter(glob(b:snippets_dir..'/**/*',0,1), 'isdirectory(v:val)==v:false')

    " amend fps to relative to b:snippets_dir
    let rel_fps = map(fps, {index,fp -> substitute(fp, expand(b:snippets_dir)..'/', '', '')})

    " filter those matching ArgLead
    return filter(rel_fps, 'v:val=~a:ArgLead')
endfunction

function! g:Snip() abort
    """ Read in a snippet from b:snippets_dir
    """
    let snip = input('snippet_name: ','', 'customlist,SnipNames')
    exec ':-1read'..b:snippets_dir..'/'..snip
endfunction
nnoremap <Leader>sn :call Snip()<CR>

"---
" filetype-specific settings
"---

augroup VimEnter *
    " auto-source session.vim in current dir
    if argc() == 0 && filereadable('Session.vim')
        au VimEnter * source Session.vim
    endif
augroup End

augroup FileType *
    au!
    au FileType * match none "clear previous highlighted matches in new buffer
    au FileType * let b:import_patterns = []
augroup End


augroup FileType vim
    au!
    au FileType vim setlocal colorcolumn=80
augroup End


" augroup Filetype julia
"     au!
"     au Filetype julia setlocal colorcolumn=80
"     if filereadable('~/Projects/JuliaFormatterSysImage/julia_formatter.so')
"         au FileType julia let b:fixer_commands = [":!julia --threads=auto -J ~/Projects/JuliaFormatterSysImage/julia_formatter.so -e 'using JuliaFormatter; format_file(\"%\")'"]
"     else
"         au FileType julia let b:fixer_commands = [":!julia -e 'using JuliaFormatter;format_file(\"%\")'"]
"     endif

"     au FileType julia let b:snippets_dir = '~/Snippets/julia'

" augroup End


augroup FileType python 
    au!
    
    au FileType python setlocal colorcolumn=80

    " fixers
    au FileType python let b:fixer_commands = [
                \'!black %',
                \'!isort %',
                \]

    au FileType python let b:snippets_dir = '~/Snippets/python'

    " lsp
    au FileType python nnoremap <buffer> <C-]> :LspGotoDefinition<CR>
    au FileType python nnoremap <buffer> K :LspHover<CR>
    au FileType python nnoremap <buffer> gR :LspRename<CR>

augroup END


augroup FileType json
    au!
    au FileType json let b:fixer_commands = [':%!python3 -m json.tool --no-ensure-ascii']
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
