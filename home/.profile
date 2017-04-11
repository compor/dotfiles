# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

# set locale
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_COLLATE=C
export LC_TIME=en_DK.UTF-8 # YYYY-MM-DD


# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	    . "$HOME/.bashrc"
    fi
fi

# change capslock key to ctrl and vice versa
setxkbmap -option ctrl:swapcaps
# apply this to disable gnome from resetting the keyboard setting in X
# gsettings set org.gnome.settings-daemon.plugins.keyboard active false 

# setup paths

# for coursera algorithms part 1
#COURSERA_ALGS="/usr/algae/"

#PATH="${COURSERA_ALGS}/bin/":$PATH
#PATH="/usr/class/cs143/bin/":$PATH
PATH="/usr/local/bin/":$PATH

# add go lang path
PATH="/usr/local/go/bin/":$PATH

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export PATH


# setup java paths

JAVA_HOME="/usr/lib/jvm/default-java"

# for coursera algorithms part 1
#CLASSPATH=$CLASSPATH:${COURSERA_ALGS}/stdlib.jar:${COURSERA_ALGS}/algs4.jar

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
    . "${SSHENV}" &> /dev/null
    trap "kill ${SSH_AGENT_PID}" 0
fi

if [ -r "${SSHENV}" ]; then
    . "${SSHENV}" &> /dev/null
fi

export ANDROID_EMULATOR_FORCE_32BIT=true

