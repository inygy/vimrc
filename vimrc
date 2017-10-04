" Author: India Heisz
" vimrc file for vim configuration
" all key mappings are denoted by a comment that starts with MM  

" -- VIM Setup --
  "Setup ~/.vim and runtime path
    let s:VIMROOT = $HOME."/.vim" 
    let &runtimepath=s:VIMROOT."," . &runtimepath    

  "Create necessary folders if they don't already exist.
    if exists("*mkdir")
      silent! call mkdir(s:VIMROOT, "p")
      silent! call mkdir(s:VIMROOT."/bundle", "p") "For pathogen
      silent! call mkdir(s:VIMROOT."/swap", "p")
      silent! call mkdir(s:VIMROOT."/undo", "p")
      silent! call mkdir(s:VIMROOT."/backup", "p")
    else
      echo "Error: Please manually create VIM setup directories found in vimrc"
    exit
    endif

  "Assign the folders, they help keep the pesky files clean and organized
    let &backupdir=s:VIMROOT.'/backup//' "end with // to ensure unique filenames
    let &directory=s:VIMROOT.'/swap//'   
    let &undodir=s:VIMROOT.'/undo//'    

  "Backups
    set backup                  "turn on backup option
    set writebackup             "backup before overwriting the current buffer
    set backupcopy=yes          "Overwrite the original backup file
    
    "Meaningful backup name, ex: filename@2056-01-09.14:59
      au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")

  "Automatically reload files that have been changed outside of vim
    set autoread
 
  "Restore last cursor position
    "but not if position is invalid or when inside an event handler, 
    "or the mark is in the first line, that is the default position.
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  
  "remember undo after quitting
    set hidden

  "Pathogen for plugins, is needy (***make runtime thingy) and has to be first
    execute pathogen#infect()                    

" -- GUI --
  "Colour Scheme
    "colorscheme solarized
    syntax enable               "syntax colours
    "set background=dark 

  "Font
    set encoding=utf-8          "changes output encoding shown in the terminal
    set fileencoding=utf-8      "change output encoding of file that is written.
 
  "Highlighting (see Formatting section for line length highlighting)
    set showmatch               "highlights matching [{()}]
    match ErrorMsg '\%>80v.\+'  "highlights lines more than 80 characters long, in red
  
  "Folding
    set foldenable              "enable folding
    set foldlevelstart=0        "0 folds open by default
    set foldnestmax=3           "3 levels of nested folds max
    set foldmethod=indent       "fold based on indent level ***Maybe make manual

  "Wrapping
    set wrap linebreak nolist  "nice soft line wraps

    "No automatic line breaks in newly entered text pls
      set textwidth=0
      set wrapmargin=0

" -- Code Formatting --
  "Indentation
  "No tabs! spaces ftw
    set tabstop=4               "number of visual spaces per found TAB 
    set softtabstop=4           "number of spaces made/deleted by TAB
    set expandtab               "tabs are spaces

  "Whitespace
  " *** dangerous to make this an autocmd, idk what to do

" -- Functional --
  "Searching
    set incsearch               "search as characters are entered
    set hlsearch                "highlight matches 
    
    "Use case insensitive search, except when using capital letters
      set ignorecase
      set smartcase

    "MM turn off search highlight
    nnoremap <leader><space> :nohlsearch<CR>

  "MM Undo Tree with Gundo, toggled with U 
    nnoremap U :GundoToggle<CR> 

  "MM Save session using the keys shift-s-s, restore session by opening vim -S
    nnoremap <S-ss> :mksession!<CR>  
                                "! to overwrite the last saved session

  "Yank and paste into the clipboard
    set clipboard=unnamedplus
  
  "Allow backspacing over everything in insert mode
    set bs=indent,eol,start 
 
  "So we can go one character past the last in normal mode. 
    set virtualedit=block

  "Traverse line breaks with arrow keys
    set whichwrap=b,s,<,>,[,]

" -- Misc --
  "Vim redraws the screen excessively so you have to tell it to chill out
    set lazyredraw              "also conveniently makes for faster macros. 

  "Spellchecker
    "set spell                  "disabed, puts annoying red highlight on code

 " -- Consider Using in the Future --
  "Nice status line at the bottom of the page
    "https://github.com/itchyny/lightline.vim

  "Useful and potentially shiny start page/screen
    "https://github.com/mhinz/vim-startify

  " Python autocompletion
    "https://github.com/davidhalter/jedi-vim

  "Does a bunch of handy stuff
    "https://github.com/airblade/vim-gitgutter

  "Makes the indents really clear and easy to see in a non-obtrusive way
    "https://github.com/nathanaelkane/vim-indent-guides

  "Easily insert commonly used snippets of text, rlly useful
    "https://github.com/garbas/vim-snipmate

  "Fuzzy Finder
    "https://github.com/junegunn/fzf 

  "Finds stuff
    "https://github.com/kien/ctrlp.vim 

  "Searcher
    "https://github.com/ggreer/the_silver_searcher

  "List all *** in a new window. Make a command that lists all the lines marked
  "with *** in a new window
  "Maybe this: https://github.com/kshenoy/vim-signature

  " Cscope

  " Dims inactive windows
    "https://github.com/blueyed/vim-diminactive

  " *** Make something that deals with Windows files and linebreaks

  " *** Make it so the plugin manager (pathogen) is setup automatically
  " and my favourite plugins are also setup automatically, 
  " including colour schemes section
