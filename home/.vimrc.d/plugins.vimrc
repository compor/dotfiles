if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" helper function suggested at vim-plug tips
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

Plug 'flazz/vim-colorschemes'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'kana/vim-operator-user'
Plug 'tomtom/tlib_vim'

Plug 'rhysd/vim-llvm'
Plug 'pboettch/vim-cmake-syntax'
Plug 'henry-hsieh/riscv-asm-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'editorconfig/editorconfig-vim'

Plug 'tmhedberg/SimpylFold'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'Konfekt/FastFold'

Plug 'preservim/nerdcommenter'
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dawikur/algorithm-mnemonics.vim'

Plug 'preservim/tagbar'
Plug 'junegunn/vim-peekaboo'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

Plug 'christoomey/vim-tmux-navigator'
Plug 'wesQ3/vim-windowswap'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'rhysd/vim-grammarous'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fcpg/vim-osc52'
Plug 'zhimsel/vim-stay'
Plug 'chrisbra/NrrwRgn'

Plug 'mg979/vim-visual-multi'
Plug 'vim-utils/vim-husk'

Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', { 'branch': 'release', 'do': { -> coc#util#install()}}
Plug 'vim-test/vim-test'
Plug 'puremourning/vimspector'
Plug 'jmcantrell/vim-virtualenv'
Plug 'lervag/vimtex'

Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

call plug#end()

