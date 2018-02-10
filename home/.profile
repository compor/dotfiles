# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022


[ -e ~/bin/git-aware-setup.sh ] && source ~/bin/git-aware-setup.sh
[ -e ~/bin/fzf-setup.sh ] && source ~/bin/fzf-setup.sh

# set locale
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_COLLATE=C
export LC_TIME=en_DK.UTF-8 # YYYY-MM-DD


# if running bash include .bashrc if it exists
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi

# change capslock key to ctrl and vice versa
setxkbmap -option ctrl:swapcaps
# apply this to disable gnome from resetting the keyboard setting in X
# gsettings set org.gnome.settings-daemon.plugins.keyboard active false 

#
# setup paths
#

LOCAL_PATH="/usr/local/bin/"
if [ -d "${LOCAL_PATH}" ]; then
  PATH="${LOCAL_PATH}":$PATH
fi

# add go lang path
GOLANG_PATH="/usr/local/go/bin/"
if [ -d "${GOLANG_PATH}" ]; then
  PATH="${GOLANG_PATH}":$PATH
fi

# set PATH so it includes user's private bin if it exists
USER_PATH="${HOME}/bin/"
if [ -d "${USER_PATH}" ]; then
  PATH="${USER_PATH}":$PATH
fi

# add cmake path
CMAKE_PATH="/usr/local/cmake/bin/"
if [ -d "${CMAKE_PATH}" ]; then
  PATH="${CMAKE_PATH}":$PATH
fi

export PATH


# setup java paths

JAVA_HOME=

JAVA_HOME_DEFAULT="/usr/lib/jvm/default-java"
if [ -d "${JAVA_HOME_DEFAULT}" ]; then
  JAVA_HOME="${JAVA_HOME_DEFAULT}"
fi
CLASSPATH=

export JAVA_HOME
export CLASSPATH


# set editors
export EDITOR=$(which vim)
export CVSEDITOR=$(which vim)

if [ "$OPSYS_TYPE" == "linux" ]; then
  export VISUAL=$(which gvim)
fi

if [ "$OPSYS_DISTRO" == "apple" ]; then
  export VISUAL=$(which macvim)
fi


# unset dbus socket address
unset DBUS_SESSION_BUS_ADDRESS

# start ssh-agent
# http://mah.everybody.org/docs/ssh
# with tweaks for damn mac os x

SSHAGENT=$(which ssh-agent)
SSHAGENTARGS="-s"
SSHAGENTPID=$(pgrep ssh-agent)
SSHENV="${HOME}/.ssh/env"

if [ -z "${SSHAGENTPID}" -a -e "${SSHAGENT}" ]; then
  eval $($SSHAGENT $SSHAGENTARGS)
  echo "export SSH_AGENT_PID=${SSH_AGENT_PID}" > "${SSHENV}"
  echo "export SSH_AUTH_SOCK=${SSH_AUTH_SOCK}" >> "${SSHENV}"
  source "${SSHENV}" &> /dev/null
  trap "kill ${SSH_AGENT_PID}" EXIT
  trap "rm ${SSHENV}" EXIT
fi

if [ -r "${SSHENV}" ]; then
  source "${SSHENV}" &> /dev/null
fi

# set up for android studio
export ANDROID_EMULATOR_FORCE_32BIT=true

