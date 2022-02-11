# bash aliases

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

# add an "alert" alias for long running commands.  Use like so:
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
alias oku='okular'

if [[ $OPSYS_DISTRO == "ubuntu" ]]; then
  alias pkgupd='sudo apt update'
  alias pkgupg='sudo apt upgrade'
  alias pkgins='sudo apt install'
  alias pkgfnd='apt search'
elif [[ $OPSYS_DISTRO == "fedora" ]]; then
  alias pkgupd='dnf check-update'
  alias pkgupg='dnf upgrade'
  alias pkgins='dnf install'
  alias pkgfnd='dnf search'
elif [[ $OPSYS_DISTRO == "apple" ]]; then
  alias pkgupd='brew update && brew cask update'
  alias pkgupg='brew upgrade'
  alias pkgins='brew install'
  alias pkgfnd='brew search'
fi
