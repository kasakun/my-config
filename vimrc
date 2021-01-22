" Plugs {

    call plug#begin('~/.vim/plugged')
    Plug 'mhinz/vim-startify'
    Plug 'mhinz/vim-signify'

    " dark power
    if has('nvim')
        Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/defx.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'bling/vim-bufferline'
    Plug 'flazz/vim-colorschemes'
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-indent'
    Plug 'reedes/vim-textobj-sentence'
    Plug 'reedes/vim-textobj-quote'
    Plug 'reedes/vim-wordy'
    Plug 'reedes/vim-litecorrect'
    Plug 'scrooloose/nerdcommenter'
    Plug 'Yggdroot/indentLine'
    Plug 'Yggdroot/LeaderF'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'Lokaltog/vim-easymotion'
    Plug 'luochen1990/rainbow'
    Plug 'jiangmiao/auto-pairs'
    Plug 'neomake/neomake'
    Plug 'iamcco/markdown-preview.vim'
    Plug 'mbbill/undotree'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'sheerun/vim-polyglot'
    Plug 'voldikss/vim-floaterm'
    Plug 'Chiel92/vim-autoformat'
    Plug 'vimwiki/vimwiki'
    call plug#end()

" }

" Plug Setting {

    " defx {
        call defx#custom#option('_', {
            \ 'winwidth': 30,
            \ 'split': 'vertical',
            \ 'direction': 'topleft',
            \ 'show_ignored_files': 0,
            \ 'buffer_name': 'defx',
            \ 'toggle': 1,
            \ 'resume': 1
            \ })

        call defx#custom#column('icon', {
            \ 'directory_icon': '',
            \ 'opened_icon': '',
            \ 'root_icon': 'ﮛ',
            \ })

        call defx#custom#column('filename', {
            \ 'min_width': 40,
            \ 'max_width': 40,
            \ })

        call defx#custom#column('mark', {
            \ 'readonly_icon': '',
            \ 'selected_icon': '',
            \ })

        " Keys {
            " Toggling defx
            nnoremap <silent> <Leader>e
                \ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()` <CR>

            nnoremap <silent> <Leader><Leader>a
                \ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()`
                \ -search=`expand('%:p')`<CR>

            " Key mapping inside defx
            autocmd FileType defx call s:defx_my_settings()
            function! s:defx_my_settings() abort
                nnoremap <silent><buffer><expr> <CR>
                    \ defx#is_directory() ?
                    \ defx#do_action('open_tree') :
                    \ defx#do_action('multi', [['drop']])
                nnoremap <silent><buffer><expr> c
                    \ defx#do_action('copy')
                nnoremap <silent><buffer><expr> m
                    \ defx#do_action('move')
                nnoremap <silent><buffer><expr> p
                    \ defx#do_action('paste')
                nnoremap <silent><buffer><expr> l
                    \ defx#do_action('open')
                nnoremap <silent><buffer><expr> E
                    \ defx#do_action('open', 'vsplit')
                nnoremap <silent><buffer><expr> P
                    \ defx#do_action('open', 'pedit')
                nnoremap <silent><buffer><expr> o
                    \ defx#do_action('open_or_close_tree')
                nnoremap <silent><buffer><expr> K
                    \ defx#do_action('new_directory')
                nnoremap <silent><buffer><expr> N
                    \ defx#do_action('new_file')
                nnoremap <silent><buffer><expr> C
                    \ defx#do_action('toggle_columns',
                    \ 'mark:indent:icon:filename:type:size:time')
                nnoremap <silent><buffer><expr> S
                    \ defx#do_action('toggle_sort', 'time')
                nnoremap <silent><buffer><expr> d
                    \ defx#do_action('remove')
                nnoremap <silent><buffer><expr> r
                    \ defx#do_action('rename')
                nnoremap <silent><buffer><expr> !
                    \ defx#do_action('execute_command')
                nnoremap <silent><buffer><expr> x
                    \ defx#do_action('execute_system')
                nnoremap <silent><buffer><expr> yy
                    \ defx#do_action('yank_path')
                nnoremap <silent><buffer><expr> .
                    \ defx#do_action('toggle_ignored_files')
                nnoremap <silent><buffer><expr> ;
                    \ defx#do_action('repeat')
                nnoremap <silent><buffer><expr> h
                    \ defx#do_action('cd', ['..'])
                nnoremap <silent><buffer><expr> ~
                    \ defx#do_action('cd')
                nnoremap <silent><buffer><expr> q
                    \ defx#do_action('quit')
                nnoremap <silent><buffer><expr> <Space>
                    \ defx#do_action('toggle_select') . 'j'
                nnoremap <silent><buffer><expr> *
                    \ defx#do_action('toggle_select_all')
                nnoremap <silent><buffer><expr> j
                    \ line('.') == line('$') ? 'gg' : 'j'
                nnoremap <silent><buffer><expr> k
                    \ line('.') == 1 ? 'G' : 'k'
                nnoremap <silent><buffer><expr> <C-l>
                    \ defx#do_action('redraw')
                nnoremap <silent><buffer><expr> <C-g>
                    \ defx#do_action('print')
                nnoremap <silent><buffer><expr> cd
                    \ defx#do_action('change_vim_cwd')
            endfunction
        " }
    "}

    " coc {
        " TextEdit might fail if hidden is not set.
        set hidden

        " Some servers have issues with backup files, see #649.
        set nobackup
        set nowritebackup

        " Give more space for displaying messages.
        set cmdheight=2

        " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
        " delays and poor user experience.
        set updatetime=300

        " Don't pass messages to |ins-completion-menu|.
        set shortmess+=c

        " Always show the signcolumn, otherwise it would shift the text each time
        " diagnostics appear/become resolved.
        set signcolumn=yes

        " Use tab for trigger completion with characters ahead and navigate.
        " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
        " other plugin before putting this into your config.
        inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-space> to trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
        " position. Coc only does snippet and additional edit on confirm.
        if has('patch8.1.1068')
        " Use `complete_info` if your (Neo)Vim version supports it.
        inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        else
        imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        endif

        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use K to show documentation in preview window.
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
        endfunction

        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Symbol renaming.
        nmap <leader>rn <Plug>(coc-rename)

        " Formatting selected code.
        xmap <leader><leader>f  <Plug>(coc-format-selected)
        nmap <leader><leader>f  <Plug>(coc-format-selected)

        augroup mygroup
        autocmd!
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder.
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        " Applying codeAction to the selected region.
        " Example: `<leader>aap` for current paragraph
        xmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)

        " Remap keys for applying codeAction to the current line.
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Apply AutoFix to problem on the current line.
        nmap <leader>qf  <Plug>(coc-fix-current)

        " Introduce function text object
        " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
        xmap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap if <Plug>(coc-funcobj-i)
        omap af <Plug>(coc-funcobj-a)

        " Use <TAB> for selections ranges.
        " NOTE: Requires 'textDocument/selectionRange' support from the language server.
        " coc-tsserver, coc-python are the examples of servers that support it.
        nmap <silent> <TAB> <Plug>(coc-range-select)
        xmap <silent> <TAB> <Plug>(coc-range-select)

        " Add `:Format` command to format current buffer.
        command! -nargs=0 Format :call CocAction('format')

        " Add `:Fold` command to fold current buffer.
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)

        " Add `:OR` command for organize imports of the current buffer.
        command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

        " Add (Neo)Vim's native statusline support.
        " NOTE: Please see `:h coc-status` for integrations with external plugins that
        " provide custom statusline: lightline.vim, vim-airline.
        set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

        " Mappings using CoCList:
        " Show all diagnostics.
        nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
        " Manage extensions.
        nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
        " Show commands.
        nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
        " Find symbol of current document.
        nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
        " Search workspace symbols.
        nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
        " Do default action for next item.
        nnoremap <silent> <space>j  :<C-u>CocNext<CR>
        " Do default action for previous item.
        nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
        " Resume latest coc list.
        nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    " }

    " floaterm {
        let g:floaterm_keymap_toggle = '<F10>'
        let g:floaterm_autoclose=2
    " }

    " LeaderF {
        let g:loaded_leaderf=1
        let g:Lf_PythonVersion=3
        let g:Lf_DefaultMode= 'Fuzzy'
        let g:Lf_WorkingDirectoryMode = 'Ac'
        let g:Lf_RootMarkers = ['.project', '.git']
        let g:Lf_GtagsAutoGenerate=1
        let g:Lf_PreviewCode=1
        let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

        " Leaderf gtags
        noremap <Leader>g :Leaderf gtags<cr>
        let g:Lf_Gtagslabel = 'native-pygments'
        noremap <leader>gr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
        noremap <leader>gd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
        noremap <leader>go :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
        noremap <leader>gn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
        noremap <leader>gp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

        noremap <Leader>t :LeaderfFunction!<cr>
        noremap <Leader>m :Leaderf mru<cr>

        " Leaderf rg
        noremap <Leader>r ::<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR><cr>
        let g:Lf_RgConfig = [
            \ "--max-columns=150",
            \ "--glob=!git/*",
            \ "--hidden"
            \ ]

        let g:Lf_ShowRelativePath = 0
        let g:Lf_HideHelp = 1
        let g:Lf_PreviewResult = {'Function':0, 'Colorscheme':1}

        let g:Lf_NormalMap = {
            \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
            \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
            \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
            \ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
            \ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
            \ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
            \ }
    " }

    " neomake {
        call neomake#configure#automake({
          \ 'TextChanged': {},
          \ 'InsertLeave': {},
          \ 'BufWritePost': {'delay': 0},
          \ 'BufWinEnter': {},
          \ }, 500)

    " }

    " vim-markdown {
        let g:vim_markdown_conceal = 0
        let g:vim_markdown_conceal_code_blocks = 0
    " }

    " undo tree {
        if isdirectory(expand("~/.vim/plugged/undotree/"))
            nnoremap <Leader>u :UndotreeToggle<CR>
            " If undotree is opened, it is likely one wants to interact with it.
            let g:undotree_SetFocusWhenToggle=1
        endif
    " }

    " rainbow {
        let g:rainbow_active=0
        nnoremap <silent><Leader><Leader>r :RainbowToggle <CR>
    " }

    " vim-airline {
        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " To use the symbols , , , , , , and .in the statusline
        " segments add the following to your .vimrc.before.local file:
        let g:airline_powerline_fonts=1
        " If the previous symbols do not render for you then install a
        " powerline enabled font.
        if !exists('g:airline_symbols')
            let g:airline_symbols = {}
        endif
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
        let g:airline_symbols.branch = ''
        let g:airline_symbols.linenr = '☰'
        let g:airline_symbols.maxlinenr = ''
        let g:airline_symbols.dirty='⚡'
        let g:airline_symbols.readonly = ''

        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
        if isdirectory(expand("~/.vim/plugged/vim-airline-themes/"))
            if !exists('g:airline_theme')
                let g:airline_theme = 'base16_spacemacs'
            endif
            if !exists('g:airline_powerline_fonts')
                " Use the default set of separators with a few customizations
                let g:airline_left_sep='›'  " Slightly fancier than '>'
                let g:airline_right_sep='‹' " Slightly fancier than '<'
            endif
        endif
    " }

    " FixWhitespace {
        nnoremap <Leader><Space> :FixWhitespace <CR>
    " }

" }

" General {
    set encoding=utf-8
    set background=dark         " Assume a dark background

    " Allow to trigger background
    function! ToggleBG()
        let s:tbg = &background
        " Inversion
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
    noremap <leader>bg :call ToggleBG()<CR>

    " if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    " endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " Restore the cursor
    function! ResCur()
        if line("'\"") <= line("$")
            silent! normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END

    " Setting up the directories {
        set noswapfile
        set undofile                    " So is persistent undo ...
        set undodir=~/.undodir/
        if has('persistent_undo')
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif
    " }

    " Save/load fold info
    au BufWinLeave ?* silent mkview
    au BufWinEnter ?* silent loadview

" }

" UI {

    set t_Co=256                    " Set 256 colors
    set termguicolors               " Set term gui colors
    colorscheme gruvbox             " Set a colorscheme
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number | set relativenumber " Hybrid line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set textwidth=80                " Text width
    set colorcolumn=+1,+41          " Ruler

" }

" Formatting {

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

" }

" Keys {

    " Fix typo
    if has("user_commands")
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
    endif
    cmap Tabe tabe

    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " Buffer shift
    nnoremap <silent>bn :bn<CR>
    nnoremap <silent>bp :bp<CR>

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$
" }
