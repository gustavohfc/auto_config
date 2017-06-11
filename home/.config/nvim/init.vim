
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
    Plug 'majutsushi/tagbar'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-syntastic/syntastic'

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

        let g:airline#extensions#tagbar#enabled = 1
        let g:airline#extensions#tagbar#flags = 'f'
        let g:airline#extensions#syntastic#enabled = 'f'
    "}}}

    "{{{ gitgutter
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

    "{{{ indexed-search
        let g:indexed_search_max_lines=6000
    "}}}

    "{{{ gutentagas
        let g:gutentags_generate_on_new = 0
    "}}}

    "{{{ tagbar
    "}}}

    "{{{ syntastic
        " Configuracao da statusline nao eh necessaria por causa do airline
        "set statusline+=%#warningmsg#
        "set statusline+=%{SyntasticStatuslineFlag()}
        "set statusline+=%*

        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0
    "}}}

"}}}

"{{{ Key map
    let mapleader = '\'
    nmap <Space> \

    "{{{ Minhas funcoes
        nnoremap <leader>n :call NumberToggle()<CR>
        nnoremap <leader>s :nohlsearch<CR>
        nnoremap <leader>w :w<CR>
    "}}}

    "{{{ gitgutter
        nnoremap <leader>h? :map <leader>h<CR>
        nnoremap <Leader>hn <Plug>GitGutterNextHunk
        nnoremap <Leader>hp <Plug>GitGutterPrevHunk
        nnoremap <Leader>ha <Plug>GitGutterStageHunk
        nnoremap <Leader>hu <Plug>GitGutterUndoHunk
        nnoremap <Leader>hv <Plug>GitGutterPreviewHunk
        nnoremap <Leader>hh :GitGutterLineHighlightsToggle<CR>
        "onoremap ih <Plug>GitGutterTextObjectInnerPending
        "onoremap ah <Plug>GitGutterTextObjectOuterPending
        "xnoremap ih <Plug>GitGutterTextObjectInnerVisual
        "xnoremap ah <Plug>GitGutterTextObjectOuterVisual
    "}}}

    "{{{ auto-pairs <F2>
        nnoremap <F2>? :map <F2><CR>
        let g:AutoPairsShortcutToggle = '<F2>t'
        let g:AutoPairsShortcutFastWrap = '<F2>w'
        let g:AutoPairsShortcutJump = '<F2>j'
        let g:AutoPairsShortcutBackInsert = '<F2>u'
    "}}}

    "{{{ nerd tree <F3>
        noremap <F3> :NERDTreeToggle<CR>
    "}}}

    "{{{ tagbar <F4>
        nnoremap <F4> :TagbarToggle<CR>
    "}}}

    "{{{ fugitive
        nnoremap <leader>g? :map <leader>g<CR>
        nnoremap <leader>gb :Gblame<CR>
        nnoremap <leader>gc :Gcommit<CR>
        nnoremap <leader>gd :Gdiff<CR>
        nnoremap <leader>gg :Ggrep<Space>
        nnoremap <leader>gl :Glog<CR>
        nnoremap <leader>gp :Git pull<CR>
        nnoremap <leader>gP :Git push<CR>
        nnoremap <leader>gs :Gstatus<CR>
        nnoremap <leader>gw :Gbrowse<CR>
    "}}}

"}}}

