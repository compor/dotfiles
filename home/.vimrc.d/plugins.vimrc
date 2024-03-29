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
Plug 'scrooloose/nerdcommenter'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'
Plug 'preservim/tagbar'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'rking/ag.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'rhysd/vim-llvm'
Plug 'Chiel92/vim-autoformat'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'rhysd/vim-clang-format'
Plug 'rhysd/vim-grammarous'
Plug 'christoomey/vim-tmux-navigator'
Plug 'pboettch/vim-cmake-syntax'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dawikur/algorithm-mnemonics.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'dense-analysis/ale'
Plug 'mhinz/vim-signify'
Plug 'vim-scripts/argtextobj.vim'
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fcpg/vim-osc52'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'neoclide/coc.nvim', { 'branch': 'release', 'do': { -> coc#util#install()}}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'mg979/vim-visual-multi'
Plug 'luochen1990/rainbow'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'vim-utils/vim-husk'
Plug 'puremourning/vimspector'
Plug 'ekalinin/Dockerfile.vim'

call plug#end()
