filetype off                  " required
set nocompatible              " be iMproved, required

" VimPlug
call plug#begin('~/.vim/plugged')


Plug 'SirVer/ultisnips'
Plug 'sniphpets/sniphpets'

" Syntax
Plug 'elzr/vim-json'
Plug 'Yggdroot/indentLine' " Vertical line indicator for blocks
Plug 'tpope/vim-commentary'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Beter sintax :TSinstall vim or go .. etc
                                                             " TSUpdate,  TSEnable highlight ... other options

Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua' " recommended if need floating window support

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-tree/nvim-web-devicons'


" Files - Utilities
Plug 'scrooloose/nerdtree'
Plug 'Shougo/echodoc.vim'     " Extra information display in echo area
Plug 'unblevable/quick-scope' " Fast jump Left Right marks
Plug 'tpope/vim-surround'
Plug 'sjl/gundo.vim'
Plug 'gcmt/breeze.vim'        " Easy html tag, attribute navigation
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color Schemas & Icons
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""
" Font
""""""""""""""""""""""""""""""""""""""""""""""""""

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont Hack:h12
endif


if has('gui_running')

    if exists('$WAYLAND_DISPLAY')
        set guifont=Hack:h14
        "set guifont=Inconsolata-g\ for\ Powerline\ 10
        "set guifont=Fira\ Code\ Retina\ 14
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h10
    elseif has("gui_win32") " Windows specific options 
        set guifont=Consolas:h12
        au GUIEnter * simalt ~x
    endif
    autocmd GUIEnter * set vb t_vb=
elseif $TERM == "xterm-256color"
    set t_Co=256
endif


""""""""""""""""""""""""""""""""""""""""""""""""""
" General Options
""""""""""""""""""""""""""""""""""""""""""""""""""

augroup autoReloadVimConfig
    au!
    autocmd bufwritepost init.vim source ~/.config/nvim/init.vim
augroup END


" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

set showmatch                               " Show matching braces when over one
set ruler                                   " Always show current position
set number                                  " Always show line-numbers
set numberwidth=5                           " Line-number margin width
set mousehide                               " Do not show mouse while typing
set linespace=0                             " Don't insert any extra pixel lines
set lazyredraw                              " Don't redraw while running macros
set wildmenu                                " Wild menu
set wildmode=longest,list,full              " Wild menu options
set cpoptions+=$
set pastetoggle=<F3>                        " Easy paste from SO
syntax enable                               " Switch syntax highlighting
                                            " also switch on highlighting the last used search pattern.

set ttyfast                                 " Bigger block size for faster scrolling

set hlsearch                                " Highlight search results

set list listchars=tab:»·,trail:·,nbsp:+    " Show the leading whitespaces
set display+=uhex                           " Show unprintables as <xx>
set display+=lastline                       " Show as much as possible of the last line.

set ignorecase                               " Ignore case when searching
set smartcase                                " When searching try to be smart about cases
set background=dark                          " We are dark people...

" Gundo python setting
let g:gundo_prefer_python3 = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme  catppuccin_mocha
let g:lightline = {'colorscheme': 'catppuccin_mocha'}
let g:airline_theme = 'catppuccin_macchiato'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Re-Maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=";"

nnoremap <leader><leader> :update<CR>zz
nnoremap <F5> :GundoToggle<CR>
noremap  <A-h>  :bprev <CR>
noremap  <A-l>  :bnext <CR>
noremap  <leader>q  :bd <CR>

" Clean highlight after search
noremap  <silent>// :nohlsearch<CR>
" Fast Indent code block inner {
nnoremap <leader>i =i{<C-o>

" Center on scroll
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Semicolon at end
inoremap <S-CR> <End>;

if (has("nvim"))
  "Neovim 
  set clipboard+=unnamedplus
endif
if (has("termguicolors"))
    map <leader>v "*p
    map <leader>c "*y
endif



"Save on exit wont work if gvim loose focus
"autocmd InsertLeave * write

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Easy move line or visual block up down
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving lines
    nnoremap <A-j> :m .+1<CR>==
    nnoremap <A-k> :m .-2<CR>==
    inoremap <A-j> <Esc>:m .+1<CR>==gi
    inoremap <A-k> <Esc>:m .-2<CR>==gi
    vnoremap <A-j> :m '>+1<CR>gv=gv
    vnoremap <A-k> :m '<-2<CR>gv=gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quick scope (Fast move in line F or  f)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Trigger a highlight only when pressing f and F.
let g:qs_highlight_on_keys = ['f', 'F', 't','T']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Match - Breeze
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" jump to all visible opening tags after the cursor position
nmap <leader>j <Plug>(breeze-jump-tag-forward)
" jump to all visible opening tags before the cursor position
nmap <leader>J <Plug>(breeze-jump-tag-backward)

" jump to all visible HTML attributes after the cursor position
nmap <leader>a <Plug>(breeze-jump-attribute-forward)
" jump to all visible HTML attributes before the cursor position
nmap <leader>A <Plug>(breeze-jump-attribute-backward)

" move to the next attribute
au FileType html,twig nmap <TAB> <Plug>(breeze-next-tag)
au FileType html,twig nmap <S-TAB> <Plug>(breeze-prev-tag)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically populate the g:airline_symbols dictionary with the powerline symbols
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

""""""""""""""""""""""""""""""""""""""""""""""""""
" Echodoc documentation in echo area
""""""""""""""""""""""""""""""""""""""""""""""""""
set noshowmode
let g:echodoc_enable_at_startup = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)
let g:indentLine_char = '┊'


" Root helper using NERDTree
autocmd BufEnter * if &ft !~ '^nerdtree$' | silent! lcd %:p:h | endif

"<C-l>  Clear cache

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Telescope config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Recent
nnoremap <silent><leader>f :Telescope find_files<cr>
" Recent Buffers
nnoremap <silent><leader>s :Telescope oldfiles<cr>
" Buffers on Project dir Recursive
nnoremap <silent><leader>b :Telescope buffers<cr>
" Tags Buffer
nnoremap <silent><leader>z :Telescope current_buffer_fuzzy_find<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tags and Omnicomplete configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable plugins and load plugin for the detected file type.
filetype plugin on
" Enable Omnicomplete features
set omnifunc=syntaxcomplete#Complete


"set complete=.,w,b,t,i,k
set completeopt=longest,menuone "like an editor

"Set lsp for go
autocmd FileType go  set omnifunc=v:lua.vim.lsp.omnifunc

"Auto pop up on Any key or .
function! OpenCompletion()
    if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z' || v:char =='.'))
        call feedkeys("\<C-x>\<C-o>", "n")
    endif
endfunction
autocmd InsertCharPre * call OpenCompletion()

" Lua code to start gopls completor  requires -->  go install golang.org/x/tools/gopls@latest
" https://dx13.co.uk/articles/2023/04/24/neovim-lsp-without-plugins/
" lsp has many functios for example when workin you can :lua vim.lsp.buf.hover()
" 
lua << EOF
local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
    pattern = "go",
    callback = function()
        local root_dir = vim.fs.dirname(
            vim.fs.find({ 'go.mod', 'go.work', '.git' }, { upward = true })[1]
        )
        local client = vim.lsp.start({
            name = 'gopls',
            cmd = { 'gopls' },
            root_dir = root_dir,
        })
        vim.lsp.buf_attach_client(0, client)
    end
})
EOF

lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


"if has('autocmd')
"  augroup OmniCompleteModes
"    autocmd!
"    autocmd FileType python        nested setlocal omnifunc=pythoncomplete#Complete
"    autocmd FileType css           nested setlocal omnifunc=csscomplete#CompleteCSS
"    autocmd FileType html,markdown nested setlocal omnifunc=htmlcomplete#CompleteTags
"    autocmd FileType javascript    nested setlocal omnifunc=javascriptcomplete#CompleteJS
"    autocmd FileType xml           nested setlocal omnifunc=xmlcomplete#CompleteTags
"endif
"  augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completor - UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Folders with Snippets
let g:UltiSnipsSnippetDirectories=["UltiSnips", "bit-snippets"]

"let g:UltiSnipsJumpForwardTrigger="<C-J>"
"let g:UltiSnipsJumpBackwardTrigger="<C-K>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP with go.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 1 tab == 4 spaces
set expandtab                    " Use spaces instead of tabs
set smarttab                     " Be smart when using tabs ;)
set tabstop=4                    " set the default tabstops
set shiftwidth=4                 " set the default autoindent
set softtabstop=4
set hidden

" Indent  after break lines 
set breakindent
set showbreak=..

" Linebreak on 500 characters
set lbr
set tw=500

set autoindent                  "Auto indent
set wrap                        "Wrap lines

command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto Close Pairs no plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap [ []<Esc>i
inoremap < <><Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERD Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F2> :NERDTreeToggle<CR>
"autocmd vimenter * if !argc() | NERDTree | endif        " Auto start with Vim
let NERDTreeWinSize = 40
let NERDTreeBookmarksFile = expand('~/.nvim/NERDTreeBookmarks')
let NERDTreeShowBookmarks=1
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let g:nerdtree_tabs_open_on_gui_startup=0
let NERDTreeIgnore=['\.o$', '\.so$', '\.bmp$', '\.class$', '^core.*', '\.vim$', '\~$',
                   \'\.pyc$', '\.pyo$', '\.jpg$', '\.gif$','\.png$', '\.ico$', '\.exe$',
                   \'\.cod$', '\.obj$', '\.mac$', '\.1st', '\.dll$', '\.pyd$', '\.zip$',
                   \'\.modules$','\.git', '\.hg', '\.svn', '\.bzr' ]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git Gutter Custom Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F4> :GitGutterSignsToggle<CR>
highlight clear SignColumn
let signify_sign_weight = 'NONE'
let g:gitgutter_signs = 0                                                           "Disabled Column Sing by default

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statuls Line  & Scroll Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2      " show status line all the time
set scrolloff=5      " don't scroll any closer to top/bottom
set sidescrolloff=5   " don't scroll any closer to left/right
set scrolljump=5      " Scroll 5 lines if cursor get closer to top or down 

" NOTE: The statusline settings below is ignored if Airline is loaded.
set statusline=%t                                                                   " tail of the filename
set statusline+=\                                                                   " whitespace
set statusline+=[%{strlen(&fenc)?&fenc:'none'},                                     " file encoding
set statusline+=%{&ff}]                                                             " file format
set statusline+=%h                                                                  " help file flag
set statusline+=%m                                                                  " modified flag
set statusline+=%r                                                                  " read only flag
set statusline+=%y                                                                  " filetype
set statusline+=%w                                                                  " filetype
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
set statusline+=%=                                                                  " left/right separator
set statusline+=\ %#warningmsg#                                                     " start warnings highlight group
set statusline+=%{exists('g:loaded_syntastic_plugin')?SyntasticStatuslineFlag():''} " SyntasticStatusLine
set statusline+=%*                                                                  " end highlight group
set statusline+=%c,                                                                 " cursor column
set statusline+=%l/%L                                                               " cursor line/total lines
set statusline+=\ %P                                                                " percent through file

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [ Highlight the match in red]  (Thx Damian Conway)
" Backups, undos, and swap files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>

function! HLNext (blinktime)
    highlight WhiteOnRed guibg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 600) . 'm'
    call matchdelete(ring)
    redraw
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backups, undos, and swap files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save your backups to a less annoying place than the current directory.
" If you have .nvim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.nvim/backup or . if all else fails.
if isdirectory($HOME . '/.nvim/backup') == 0
  :silent !mkdir -p ~/.nvim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.nvim/backup/
set backupdir^=./.nvim-backup/
set backup
" Prevent backups from overwriting each other. The naming is weird,
" since I'm using the 'backupext' variable to append the path.
" So the file '/home/docwhat/.nvimrc' becomes '.nvimrc%home%docwhat~'
if has("autocmd")
  autocmd BufWritePre * let &backupext = substitute(expand('%:p:h'), '/', '%', 'g') . '~'
endif


" Save your swp files to a less annoying place than the current directory.
" If you have .nvim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.nvim/swap, ~/tmp or .
if isdirectory($HOME . '/.nvim/swap') == 0
  :silent !mkdir -p ~/.nvim/swap >/dev/null 2>&1
endif
set directory=./.nvim-swap//
set directory+=~/.nvim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.nvim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .nvim-undo first, then ~/.nvim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.nvim/undo') == 0
    :silent !mkdir -p ~/.nvim/undo > /dev/null 2>&1
  endif
  set undodir=./.nvim-undo//
  set undodir+=~/.nvim/undo//
  set undofile
  set undolevels=1000         " maximum number of changes that can be undone
  set undoreload=10000        " maximum number lines to save for undo on a buffer reload
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on vim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif

