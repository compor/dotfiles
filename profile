# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.


# restrict mask as much as possible
umask 077


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


# setup paths

# for coursera algorithms part 1
#COURSERA_ALGS="/usr/algae/"

#PATH="${COURSERA_ALGS}/bin/":$PATH
PATH="/usr/class/cs143/bin/":$PATH
PATH="/usr/local/bin/":$PATH
PATH="${HOME}/bin/":$PATH

export PATH


# setup java classpath

# for coursera algorithms part 1
#CLASSPATH=$CLASSPATH:${COURSERA_ALGS}/stdlib.jar:${COURSERA_ALGS}/algs4.jar
CLASSPATH=

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


# start ssh-agent
# http://mah.everybody.org/docs/ssh
# with tweaks for damn mac os x

SSHAGENT=$(which ssh-agent)
SSHAGENTARGS="-s"
SSHAGENTPID=$(pgrep ssh-agent)
SSHENV="${HOME}/.ssh/ssh_env"

if [ -z "${SSHAGENTPID}" ] && [ -x "${SSHAGENT}" ]; then
    eval $($SSHAGENT $SSHAGENTARGS)
    echo "export SSH_AGENT_PID=${SSH_AGENT_PID}" > "${SSHENV}"
    echo "export SSH_AUTH_SOCK=${SSH_AUTH_SOCK}" >> "${SSHENV}"
    trap "kill ${SSH_AGENT_PID}" 0
else
    if [ -r "${SSHENV}" ]; then
        . "${SSHENV}" &> /dev/null
    fi
fi

export ANDROID_EMULATOR_FORCE_32BIT=true

