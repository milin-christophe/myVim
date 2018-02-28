" VIM Configuration - milinc
" February 2016


" Explicitly get out of vi-compatible mode ================
    set nocompatible


" Enable pathogen (plugin manager) ========================
    call pathogen#infect()
    call pathogen#helptags()


" Basics ==================================================
    set fileformat=dos
    set fileformats=dos,unix,mac
    set enc=utf-8
    setglobal fileencoding=utf-8
    if has('mouse')
      set mouse=a   " enable mouse everywhere
    endif
    set backspace=indent,eol,start  " Allow backspacing over everything
                                    " in insert mode
"   set cpoptions=aABceFsmq
    "             |||||||||
    "             ||||||||+-- When joining lines, leave the cursor between joined lines
    "             |||||||+-- When a new match is created (showmatch) pause for .5
    "             ||||||+-- Set buffer options when entering the buffer
    "             |||||+-- :write command updates current file name automatically add <CR> to the last line when using :@r
    "             |||+-- Searching continues at the end of the match at the cursor position
    "             ||+-- A backslash has no special meaning in mappings
    "             |+-- :write updates alternative file name
    set clipboard+=unnamed " share windows clipboard


" Syntax highlighting =====================================
    syntax on
    " Active les comportement spécifique aux types de fichiers
    filetype on         "  Enable file type detection.
    filetype plugin on
    filetype indent on  " Automatically do language-dependent indenting.
    " if .txt file, render pandoc markdown highlighting
    au BufRead,BufNewFile *.txt setlocal ft=markdown.pandoc


" Recovery and backup =====================================
    set history=50  " keep 50 lines of command line history
    set backup      " keep a backup file (restore to previous version)
    set undofile    " keep an undo file (undo changes after closing)
    set undolevels=1000         " How many undos
    set undoreload=10000        " number of lines to save for undo
    set dir=~/.vim/temp         " where to save temp files
    set backupdir=~/.vim/backup " where to put backup files
    set undodir=~/.vim/undo     " directory to place undo files
    set hidden " you can change buffers without saving


" Search options ==========================================
    set ignorecase  " ignore case in (search) patterns
    set smartcase   " when the (search) pattern contains uppercase chars,
                    " don't ignore case
    set incsearch   " while searching, immediately show first match
    set hlsearch    " highlight all the matches for the search
                    " (disable until next search with :noh)
    set nostartofline   " leave my cursor where it was


" Disable warnings ========================================
    set novisualbell    " don't blink
    set noerrorbells    " don't make noise
    set t_vb=
    set tm=50


" Vim UI ==================================================
    set title       " set the title
    set number      " show line numbers by default
    set ruler       " show cursor position in left bottom corner
    set showcmd     " show the current command in the statusline
    set laststatus=2 " always show the status line
    set showmatch   " show matching brackets
    set lazyredraw  " do not redraw while running macros
    set scrolloff=0      " Keep 0 lines (top/bottom) for scope
    set sidescrolloff=10 " Keep 5 lines at the size
    set linespace=5 " insert extra pixel lines betweens rows
    set cursorline  " highlight the current line
    set splitbelow  " open a new horizontal window below the current
                    " window instead of above
    set wildmenu    " turn on command line completion wild style
    " ignore these list file extensions
    set wildignore=*.docx,*.doc,*.xlsx,*.xls,*.pdf,*.exe,*.jpg,*.gif,*.png
    set wildmode=longest:full       " complete mode for wildmenu
    set wildmode+=full              " when pressing tab a second time,
                                    " fully complete
    if exists("&wildignorecase")
        set wildignorecase          " ignore case when completing filenames
    endif
    set virtualedit=block,onemore   " allow cursor after end of line in 
                                    " visual block mode and allow cursor 
                                    " one char after line end
    set display+=lastline           " display wrapped lines at bottom 
                                    " instead of @ symbols
    set fillchars=vert:\ ,fold:-    " fill vertical splitlines with spaces 
                                    " instead of the ugly |-char; Default 
                                   " - for folds
    set statusline=%f%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    "              | | | | |  |   |      |  |     |    |
    "              | | | | |  |   |      |  |     |    + current column
    "              | | | | |  |   |      |  |     +-- current line
    "              | | | | |  |   |      |  +-- current % into file
    "              | | | | |  |   |      +-- current syntax in square brackets
    "              | | | | |  |   +-- current fileformat
    "              | | | | |  +-- number of lines
    "              | | | | +-- preview flag in square brackets
    "              | | | +-- help flag in square brackets
    "              | | +-- readonly flag in square brackets
    "              | +-- rodified flag in square brackets
    "              +-- full path to file in the buffer
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") | 
        \   exe "normal! g`\"" |
        \ endif
    set t_Co=256
    set background=dark
    colorscheme apprentice


" Text Formatting/Layout ==================================
    set expandtab       " expand tabs to spaces
    set shiftwidth=4    " number of spaces to use for each step of indent
    set softtabstop=4   " number of spaces that a tab counts for while editing
    set shiftround      " round the indent to a multiple of shiftwidth
                        " ex: when at 3 spaces, and I hit > ... go to 4, not 5
    set tabstop=8       " real tabs should be 8, and they will show with set list on
    set autoindent      " automatically indent a new line
    set wrap            " wrap line where too long
    set linebreak       " only wrap after words, not inside words
    set breakindent     " indent after soft break


" Folding =================================================
    set foldenable " Turn on folding
    set foldmethod=indent " Fold on the indent (damn you python)
    set foldlevel=100 " unfold everything
    set fdc=4   " 3 columns on the left for folding
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
    function SimpleFoldText() " {
        return getline(v:foldstart).' '
    endfunction " }
    set foldtext=SimpleFoldText() " Custom fold text function (cleaner than default)


" GUI options =============================================
    if has("gui_running")
        set guifont=Liberation\ Mono\ 13
        set antialias
        set background=dark
        colorscheme apprentice
        set guioptions-=T   " remove the toolbar
        set guioptions-=r   " remove the right scrollbar
        set mousehide " hide the mouse cursor when typing
    endif


" Mappings ================================================
    if has('langmap') && exists('+langnoremap')
      " Prevent that the langmap option applies to characters that result from a
      " mapping.  If unset (default), this may break plugins (but it's backward
      " compatible).
      set langnoremap
    endif

    " remap <ESC> key
    set timeout timeoutlen=1000 ttimeoutlen=100
    imap ,, <ESC>
    map ,, <ESC>

    " Treat long lines as break lines
    nmap j gj
    nmap k gk
    nmap $ g$
    nmap 0 g0

    " ctrl j / ctrl k scroll one line in normal mode
    nmap <C-j> <C-e>
    nmap <C-k> <C-y>

    " Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
    nmap <M-j> mz:m+<cr>`z
    nmap <M-k> mz:m-2<cr>`z
    vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
    vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


    " windows style shortcuts
    map <C-a> ggVG      " select all
    map <C-c> "+ygv     " copy
    map <C-x> "+x       " cut
    map <C-p> "+gP      " paste

    " F6 activate/desactivate spelling in French
    map <silent> <F6> "<Esc>:silent setlocal spell! spelllang=fr<CR>"
    " F7 activate/desactivate spelling in English
    map <silent> <F7> "<Esc>:silent setlocal spell! spelllang=en<CR>"
    " F9 activate/desactivate Goyo
    map <F9> :Goyo<cr>:set nu<cr>
    " F10 activate/desactivate NerdTree
    map <F10> :NERDTreeToggle<cr>


" Delete trailing white space on save, useful for Python ===
    func! DeleteTrailingWS()
      exe "normal mz"
      %s/\s\+$//ge
      exe "normal `z"
    endfunc
    autocmd BufWrite *.py :call DeleteTrailingWS()


" vim-pandoc settings =====================================
    let g:pandoc#folding#fdc = 0
    let g:pandoc#spell#default_langs = ['fr', 'en']
    let g:pandoc#syntax#codeblocks#embeds#langs = ['python', 'html', 'php', 'vim', 'sql']


" Goyo settings ===========================================
    let g:goyo_width = 90           " default: 80
    let g:goyo_margin_top = 0       " default: 4
    let g:goyo_margin_bottom = 0    " default: 4
    let g:goyo_linenr = 0           " default: 0

