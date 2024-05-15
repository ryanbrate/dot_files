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

set termguicolors
colorscheme default
" set background=dark

" ------
"  default code folding
" ------
set foldmethod=manual
set nofoldenable
set foldcolumn=2

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
" setup vimgrep for quick <cword> search in current and sub-folders for the
" current filetype
" ------
command! -nargs=* VG exec len(split(<q-args>)) == 0?
    \'vimgrep '..expand("<cword>")..' '..'**/*.'..expand('%:e')..'<CR>|copen'
    \:
    \'vimgrep '..<q-args>..' '..'**/*.'..expand('%:e')..'<CR>|copen'

" ------
" plugins
" ------
call plug#begin()
    Plug 'tpope/vim-commentary'
    Plug 'mbbill/undotree'
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
nnoremap <Leader>we :e ~/dot_files/.vimrc<cr>

" ------
" vimscript documentation
" ------
nnoremap <Leader>vf :h builtin<cr>

" ------
" (basic wimwiki replacement shortcuts)
" ------
nnoremap <Leader>ww :e ~/index.md<cr>
nnoremap <Leader>wi :e ~/scratch.md<cr>

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
    echom rel_fps

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

function! DevDocs(ngram, ft) abort

    if exists('b:DD_call') 

        " ======
        "  The Basic functionality
        "  (everything else is a bonus)
        " ======
        " save query documentation to ~/.vim/doc file
        for call_string in ['silent '..b:DD_call..' > ~/.vim/doc']
            let call_string = substitute(call_string, '<ngram>', a:ngram, 'g')
            exec call_string
        endfor

        " open the saved documentation in a new buffer,
        " ... set documentation buffer filetype as 'DD_doc'
        let l:DD_call_copy = b:DD_call
        for call_string in ['e ~/.vim/doc', 'set ft=DD_doc', 'redraw!', 'normal gg']
            exec call_string
        endfor

        " ... set b:DD_call for documentation buffer
        let b:DD_call = l:DD_call_copy

        " add to cmd history
        call histadd('cmd', ':DD '..a:ngram)

        " ======
        " record query history by filetype
        " (used to power custom list)
        " ======
        call DevDocs_record(a:ngram, a:ft, 'a')
        if a:ft == 'DD_doc'
            call DevDocs_record(a:ngram, 'DD_doc', 'a')
        else
            call DevDocs_record(a:ngram, 'DD_doc', 'w')
        endif

    endif
endfunction

function! DevDocs_record(ngram, ft, mode)
    " Record queries by filetype in a .json
    "
    " Args: 
    "   mode (str): 'a' appends to history json for filetype, 'w' overwrites    

    " record fp by filetype
    let fp = expand('~/.vim/doc_history_'..a:ft..'.json')

    " append to or overwrite history
    let history_list = []
    if a:mode == 'a'
        " get existing history if present
        if filereadable(fp)
            let history_list = json_decode(readfile(fp)[0])
        endif
        " add unseen ngrams (queries) to history
        if index(history_list, a:ngram) == -1
            call add(history_list, a:ngram)
        endif
    elseif a:mode == 'w'
        call add(history_list, a:ngram)
    endif

    " save history wrt., filetype
    call writefile([json_encode(sort(history_list))], fp)
endfunction

function! DevDocs_get_history(ArgLead, CmdLine, CursorPos) abort
    " Return a custom list of DD history wrt., buffer filetype
    if exists('b:DD_call') 
        let fp = expand('~/.vim/doc_history_'..&ft..'.json')
        let history_list = []
        if filereadable(fp)
            let history_list = json_decode(readfile(fp)[0])
        endif
        return filter(history_list, 'v:val=~a:ArgLead')
    else
        return []  " return blank list, if b:DD_call doesn' exist
    endif
endfunction
silent! command! -complete=customlist,DevDocs_get_history -nargs=1 DD call DevDocs(<q-args>, &ft)

function! DevDocsDelete(ngram, ft)
    " open relevant history list for filetype 
    let fp = expand('~/.vim/doc_history_'..a:ft..'.json')
    if filereadable(fp)
        let history_list = json_decode(readfile(fp)[0])

        " remove gram from history and save the amended list
        let ngram_index = index(history_list, a:ngram)
        if ngram_index != -1
            call remove(history_list, ngram_index)
            call writefile([json_encode(history_list)], fp)
        endif
    endif
endfunction
silent! command! -complete=customlist,DevDocs_get_history -nargs=1 DDel call DevDocsDelete(<q-args>, &ft)

"---
" filetype-specific settings
"---

augroup VimEnter *
    " auto-source session.vim in current dir
    if argc() == 0 && filereadable('session.vim')
            au VimEnter * source session.vim
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


augroup Filetype julia
    au!
    au Filetype julia setlocal colorcolumn=80
    if filereadable('~/Projects/JuliaFormatterSysImage/julia_formatter.so')
        au FileType julia let b:fixer_commands = [":!julia --threads=auto -J ~/Projects/JuliaFormatterSysImage/julia_formatter.so -e 'using JuliaFormatter; format_file(\"%\")'"]
    else
        au FileType julia let b:fixer_commands = [":!julia -e 'using JuliaFormatter;format_file(\"%\")'"]
    endif
    au FileType julia let b:DD_call = '!julia -E "try; eval(Meta.parse(\"using \" * split(\"<ngram>\", \".\")[1])); catch; end; @doc <ngram>"'
    au FileType julia let b:snippets_dir = '~/Projects/Snippets/julia'

augroup End

augroup FileType python 
    au!
    
    au FileType python setlocal colorcolumn=80

    " fixers
    au FileType python let b:fixer_commands = [
                \'!black %',
                \'!isort %',
                \]

    au FileType python let b:snippets_dir = '~/Projects/Snippets/python'
    au FileType python let b:DD_call = '!python3 -m pydoc <ngram>'
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
