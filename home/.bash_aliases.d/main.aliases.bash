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

if [[ -x $(which rg) ]]; then
  alias g='rg'
elif [[ -x $(which ag) ]]; then
  alias g='ag'
else
  alias g='grep'
fi
