#
#
#

alias c='clear'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias ls='ls --color=auto'
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

if [[ $OPSYS_DISTRO == "ubuntu" ]]; then
  alias pkgupd='sudo apt-get update'
  alias pkgupg='sudo apt-get upgrade'
  alias pkgins='sudo apt-get install'
  alias pkgfnd='sudo apt-cache search'
elif [[ $OPSYS_DISTRO == "apple" ]]; then
  alias pkgupd='brew update && brew cask update'
  alias pkgupg='brew upgrade'
  alias pkgins='brew install'
  alias pkgfnd='brew search'
fi

