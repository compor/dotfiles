# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.


# restrict mask as much as possible
umask 077


# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	    . "$HOME/.bashrc"
    fi

    if [ -f "$HOME/bin/detect_os.sh" ]; then
        . "$HOME/bin/detect_os.sh"
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


export EDITOR=$(which vim)
export CVSEDITOR=$(which vim)

if [ "$OPSYS_TYPE" == "linux" ]; then
    export VISUAL=$(which gvim)
fi


if [ "$OPSYS_DISTRO" == "apple" ]; then
    export VISUAL=$(which macvim)
fi


export ANDROID_EMULATOR_FORCE_32BIT=true


eval $(ssh-agent)


