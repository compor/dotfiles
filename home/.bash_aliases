#
#
#

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias sudo='sudo '

alias c='clear'

alias sl='ls'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias l1='ls -F1'

alias mkdir='mkdir -vp'
alias mount='mount | column -t'

# navigation
alias p='pushd'
alias o='popd'

# safety first
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias rm='rm -i'

# other programs
alias mk='make'
alias rr='ranger'
alias mux='tmuxinator'
alias zt='zathura'
#alias vim='vim --servername vim'

if [[ $OPSYS_DISTRO == "ubuntu" ]]; then
  alias pkgu='sudo apt update'
  alias pkgg='sudo apt upgrade'
  alias pkgi='sudo apt install'
  alias pkgf='apt search'
elif [[ $OPSYS_DISTRO == "fedora" ]]; then
  alias pkgu='dnf check-update'
  alias pkgg='dnf upgrade'
  alias pkgi='dnf install'
  alias pkgf='dnf search'
elif [[ $OPSYS_DISTRO == "apple" ]]; then
  alias pkgu='brew update && brew cask update'
  alias pkgg='brew upgrade'
  alias pkgi='brew install'
  alias pkgf='brew search'
fi
