# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022


#[ -e ~/bin/git-aware-setup.sh ] && . ~/bin/git-aware-setup.sh
[ -e ~/bin/fzf-setup.sh ] && . ~/bin/fzf-setup.sh

# set locale
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_COLLATE=C
export LC_TIME=en_DK.UTF-8 # YYYY-MM-DD


# if running bash include .bashrc if it exists
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

# change capslock key to ctrl and vice versa
setxkbmap -option ctrl:swapcaps
# apply this to disable gnome from resetting the keyboard setting in X
# gsettings set org.gnome.settings-daemon.plugins.keyboard active false

#
# setup paths
#

_LOCAL_PATH="/usr/local/bin/"
if [ -d "${_LOCAL_PATH}" ]; then
  PATH="${_LOCAL_PATH}":$PATH
fi

# add ruby path
_RUBYGEM_PATH="${HOME}/.gem/bin/"
if [ -d "${_RUBYGEM_PATH}" ]; then
  PATH="${_RUBYGEM_PATH}":$PATH
fi
export GEM_HOME="${HOME}/.gem"

# add go lang path
_GOLANG_PATH="/usr/local/go/bin/"
if [ -d "${_GOLANG_PATH}" ]; then
  PATH="${_GOLANG_PATH}":$PATH
fi

_GOPATH=$(go env GOPATH)
if [ -d "${_GOPATH}" ]; then
  PATH="${_GOPATH}/bin":$PATH
fi

# add rust lang path
_RUSTLANG_PATH="${HOME}/.cargo/bin/"
if [ -d "${_RUSTLANG_PATH}" ]; then
  PATH="${_RUSTLANG_PATH}":$PATH
fi

# set PATH so it includes user's private bin if it exists
_USER_PATH="${HOME}/bin/"
if [ -d "${_USER_PATH}" ]; then
  PATH="${_USER_PATH}":$PATH
fi

# add cmake path
_CMAKE_PATH="/usr/local/cmake/bin/"
if [ -d "${_CMAKE_PATH}" ]; then
  PATH="${_CMAKE_PATH}":$PATH
fi

export PATH


# setup java paths

JAVA_HOME=

JAVA_HOME_DEFAULT="/usr/lib/jvm/jdk"
if [ -d "${JAVA_HOME_DEFAULT}" ]; then
  JAVA_HOME="${JAVA_HOME_DEFAULT}"
fi
CLASSPATH=

export JAVA_HOME
export CLASSPATH


# set editors
export EDITOR=$(which vim)
export CVSEDITOR=$(which vim)

if [ "${OPSYS_TYPE}" = "linux" ]; then
  export VISUAL=$(which gvim)
fi

if [ "${OPSYS_DISTRO}" = "apple" ]; then
  export VISUAL=$(which macvim)
fi

# set thefuck utility alias
THEFUCK=$(which thefuck)

if [ -e "${THEFUCK}" ]; then
  eval $(thefuck --alias frak)
fi

# unset dbus socket address
unset DBUS_SESSION_BUS_ADDRESS

## start ssh-agent
## http://mah.everybody.org/docs/ssh
## with tweaks for damn mac os x

#SSHAGENT=$(which ssh-agent)
#SSHAGENTARGS="-s"
#SSHAGENTPID=$(pgrep ssh-agent)
#SSHENV="${HOME}/.ssh/env"

#if [ -z "${SSHAGENTPID}" -a -e "${SSHAGENT}" ]; then
  #eval $($SSHAGENT $SSHAGENTARGS)
  #echo "export SSH_AGENT_PID=${SSH_AGENT_PID}" > "${SSHENV}"
  #echo "export SSH_AUTH_SOCK=${SSH_AUTH_SOCK}" >> "${SSHENV}"
  #. "${SSHENV}" >/dev/null 2>&1
  #trap 'kill "${SSH_AGENT_PID}"' EXIT
  #trap 'rm "${SSHENV}"' EXIT
#fi

#if [ -r "${SSHENV}" ]; then
  #. "${SSHENV}" >/dev/null 2>&1
#fi

# set up for android studio
export ANDROID_EMULATOR_FORCE_32BIT=true


export PATH="$HOME/.cargo/bin:$PATH"
