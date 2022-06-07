# ~/.bashrc: executed by bash(1) for non-login shells.

# execution order explained at:
# http://wiki.bash-hackers.org/scripting/bashbehaviour

#
# both interactive and non-interactive usage
#

if [ -f "$HOME/bin/detect_os.sh" ]; then
  . "$HOME/bin/detect_os.sh"
fi

#
# interactive usage
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# sudo-aware shell prompt
if [ -z "$LOGNAME" ]; then
  LOGNAME=$(logname)
fi

UUSER=$([ "${LOGNAME}" = "${USER}" ] && echo "${USER}" || echo '$(tput setaf 1)${LOGNAME}$(tput sgr0) as ${USER}')
PS1="[${UUSER}@\h \W]\\$ "

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=erasedups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1024
HISTFILESIZE=2048

# ignore specific commands
HISTIGNORE="history:ls:ll:pwd:clear:[bf]g:exit"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# more sophisticated glob matching
shopt -s extglob

# move into a directory by using just the name
shopt -s autocd

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

function is_linux_term() {
  case "$TERM" in
  xterm* | rxvt* | screen*) return 0 ;;
  *) return 1 ;;
  esac
}

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color) color_prompt='' ;;
screen-color) color_prompt='' ;;
xterm-256color) color_prompt=yes ;;
screen-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# if this is an xterm set the title to user@host:dir
is_linux_term
if [ "$?" -eq 0 ]; then
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
fi

# set vi editing mode
set -o vi

# correct minor spelling mistakes in paths
shopt -s cdspell

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  if [ -r ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

# alias definitions
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

eval `keychain --eval`

GPG_TTY=$(tty)
export GPG_TTY

# TODO make sure this works
if [ -n "$TMUX" ]; then
  function refresh() {
    echo "refreshing vars"
    eval $(tmux showenv -s DISPLAY)
    eval $(tmux showenv -s SSH_AUTH_SOCK)
    eval $(tmux showenv -s SSH_CONNECTION)
  }
else
  function refresh() {
    :
  }
fi

# enable programmable completion features (you don't need to enable this
# if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -x "$(which direnv)" ]; then
  eval "$(direnv hook bash)"
fi

is_linux_term
if [ "$?" -eq 0 ]; then
  if [ -x "$(which thefuck)" ]; then
    eval "$(thefuck --alias frak)"
  fi
  if [ -x "$(which starship)" ]; then
    eval "$(starship init bash)"
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# added by travis gem
[ -f /home/vasich/.travis/travis.sh ] && source /home/vasich/.travis/travis.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/vasich/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/vasich/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/vasich/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/vasich/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

