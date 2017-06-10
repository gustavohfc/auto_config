
"{{{ vim-plug
    call plug#begin()

    Plug 'joshdick/onedark.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'Yggdroot/indentLine'
    Plug 'vim-airline/vim-airline'
    Plug 'airblade/vim-gitgutter'
    Plug 'jiangmiao/auto-pairs'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'henrik/vim-indexed-search'
    Plug 'ntpeters/vim-better-whitespace'

    call plug#end()
"}}}

"{{{Vim options
    "{{{ Geral
        set mouse=a
        set showcmd " Mostra o ultimo comando
        set cursorline " Destaca a linha do cursor
        set foldmethod=marker
        set history=1000
        set ignorecase
        set smartcase
        set title " Altera o titulo da janela
        set scrolloff=3
        set incsearch
        set hlsearch
    "}}}

    "{{{ Tab options
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
        set expandtab

        " Destaca o caracter TAB
        highlight SpecialKey ctermfg=RED
        set list
        set listchars=tab:T>
    "}}}

    "{{{ Numeracao das linhas
        set number
        function! NumberToggle()
            if(&relativenumber == 1)
                set norelativenumber
            else
                set relativenumber
            endif
        endfunc
    "}}}
"}}}

"{{{ Plugins options
    "{{{ onedark.vim
        set termguicolors
        syntax on
        colorscheme onedark
    "}}}

    "{{{ indentLine
        let g:indentLine_char = '┆'
        let g:indentLine_indentLevel = 30
        let g:indentLine_showFirstIndentLevel = 1
    "}}}

    "{{{ airline
        let g:airline_powerline_fonts = 1
        let g:airline_theme='onedark'
        set laststatus=2
    "}}}

    "{{{ vim-gitguttet
        set updatetime=250
        let g:gitgutter_map_keys = 0
    "}}}

    "{{{ auto-pairs
        let g:AutoPairsFlyMode = 1
    "}}}

    "{{{ nerd tree
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " Abre o Nerdtree quando o vim e' iniciado sem nenhum arquivo
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Fecha o vim quando resta apenas a janela do NERDTree
        let NERDTreeMouseMode = 2 " Um clique para abrir pastas e dois para arquivos
        let NERDTreeShowHidden = 1 " Um clique para abrir pastas e dois para arquivos
    "}}}

    "{{{ nerd tree git plugin
        let g:NERDTreeShowIgnoredStatus = 1 " Mostra arquivos ignorados, MUITO PESADO
    "}}}

    "{{{ vim-indexed-search
        let g:indexed_search_max_lines=6000
    "}}}

    "{{{ vim-gutentagas
        let g:gutentags_generate_on_new = 0
    "}}}

"}}}

"{{{ Key map
    let mapleader = "\<Space>"

    "{{{ Minhas funcoes
        nnoremap <leader>n :call NumberToggle()<CR>
        nnoremap <leader><space> :nohlsearch<CR>
    "}}}

    "{{{ vim-gitguttet
        nmap ]h <Plug>GitGutterNextHunk
        nmap [h <Plug>GitGutterPrevHunk
        nmap <Leader>ha <Plug>GitGutterStageHunk
        nmap <Leader>hr <Plug>GitGutterUndoHunk
        nmap <Leader>hv <Plug>GitGutterPreviewHunk
        omap ih <Plug>GitGutterTextObjectInnerPending
        omap ah <Plug>GitGutterTextObjectOuterPending
        xmap ih <Plug>GitGutterTextObjectInnerVisual
        xmap ah <Plug>GitGutterTextObjectOuterVisual
    "}}}

    "{{{ auto-pairs <F2>
        let g:AutoPairsShortcutToggle = '<F2>t'
        let g:AutoPairsShortcutFastWrap = '<F2>w'
        let g:AutoPairsShortcutJump = '<F2>j'
        let g:AutoPairsShortcutBackInsert = '<F2>u'
    "}}}

    "{{{ nerd tree
        noremap <F3> :NERDTreeToggle<CR>
    "}}}


"}}}

