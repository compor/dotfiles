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

alias j='autojump'

# safety first
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias rm='rm -i'

alias mk='make'

# TODO add checks for mac os
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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" \
"$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


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

