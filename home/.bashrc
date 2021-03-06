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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color) color_prompt='' ;;
xterm-256color) color_prompt=yes ;;
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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;

esac

# use powerline prompt
function _update_ps1() {
  PS1="$(
    powerline-go -error $? \
      -path-aliases "/bulk/workbench/repos=REPOS,/bulk/workbench/=WBNCH,/bulk/carenot/downloads/=DOWNLOADS" \
      -newline \
      -numeric-exit-codes \
      -modules \
      "venv,user,host,ssh,cwd,perms,git,hg,jobs,exit,root,docker,aws"
  )"
}

#if [ "$TERM" != "linux" ] && [ -x "$(which powerline-go)" ]; then
#PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

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

# tmuxinator completions
if [ -f ~/.bash/tmuxinator/tmuxinator.bash ]; then
  source ~/.bash/tmuxinator/tmuxinator.bash
fi

# alias definitions
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

GPG_ENVFILE="${HOME}/.gnupg/gpg-agent.env"

if [ -f "${GPG_ENVFILE}" ]; then
  . "${GPG_ENVFILE}"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
else
  GPG_AGENT_INFO=$(gpgconf --list-dirs agent-socket)
  SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
fi

GPG_TTY=$(tty)
export GPG_TTY

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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ "$TERM" != "linux" ] && [ -x "$(which thefuck)" ]; then
  eval "$(thefuck --alias frak)"
fi

if [ -x "$(which direnv)" ]; then
  eval "$(direnv hook bash)"
fi

eval "$(starship init bash)"

# added by travis gem
[ -f /home/vasich/.travis/travis.sh ] && source /home/vasich/.travis/travis.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
