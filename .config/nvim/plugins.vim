""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Installation ------------------------------------------------------------- {{{

" TODO: Get through all plugins, read docs and customize them.
call plug#begin(stdpath('data') .. '/plugged')

Plug 'Yggdroot/indentLine'
Plug 'dstein64/vim-startuptime'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'lifepillar/vim-cheat40'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

" IMPORTANT: This has to be the last one.
Plug 'ryanoasis/vim-devicons'

call plug#end()

" }}}

" Plugins settings --------------------------------------------------------- {{{

" Gruvbox colorscheme
" TODO: Find a neat way to get around italics being disabled in
" Alacritty (despite being supported) and the strange hack of checking
" $TERM_ITALICS in Gruvbox repo. Probably, some .terminfo should be utilized.
let g:gruvbox_italic = 1
let g:gruvbox_guisp_fallback = 'bg'
colorscheme gruvbox


" UltiSnips
" TODO: Manage coc.nvim integration.
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-h>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsSnippetDirectories=[$HOME .. '/.config/UltiSnips']

" lightline.vim
" TODO: Customize lightline more. Ideas:
" * Use full path to the file in lightline.
" * Take a look at example configurations of lightline.
" * Take a look at configurations of powerline, airline, etc.
function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype .. ' ' .. WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? (&fileformat .. ' ' .. WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" Add diagnostic info for lightline.vim
let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status'
  \ },
  \ }

" Vimtex
let g:vimtex_compiler_latexmk = {'callback' : 0}
" Always prefer LaTeX over plain TeX.
let g:tex_flavor = 'latex'

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

" vim-better-whitespace
" Highlight trailing whitespace. This makes missing an extra whitespace
" infinitely harder. Also, use this plugin to remove trailing whitespaces upon
" saving the file.
augroup comments_highlight
  autocmd!
  highlight ExtraWhitespace ctermbg=DarkMagenta
augroup END

" vim-startify
function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ..' '.. entry_path'
endfunction

" NERD commenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" indentLine
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']

" sneak
let g:sneak#s_next = 1

" coc.nvim ----------------------------------------------------------------- {{{

" Give more space for the messages.
set cmdheight=2

" Unify CoC.nvim config across NeoVim and Vim.
let g:coc_config_home = $HOME .. '/.config/coc'

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" }}}

" treesitter.nvim ---------------------------------------------------------- {{{

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false,
  },
}
EOF

" Use TreeSitter-based folding.
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

" }}}

" }}}
