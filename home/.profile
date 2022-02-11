# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

[[ -e ${HOME}/bin/fzf-setup.sh ]] && . "${HOME}/bin/fzf-setup.sh"

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

GPG_VERSION=$(gpg-agent --version | head -n1 | awk '{print $3}' |
  awk -F. '{ v=1000*$1+100*$2+$3; print v}')

GPG_ENVFILE="${HOME}/.gnupg/gpg-agent.env"

if [[ "${GPG_VERSION}" -lt 2200 ]]; then
  if test -f "${GPG_ENVFILE}" && kill -0 "$(grep GPG_AGENT_INFO "$GPG_ENVFILE" | cut -d: -f 2)" 2>/dev/null; then
    eval "$(cat "${GPG_ENVFILE}")"
  else
    eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "${GPG_ENVFILE}")"
  fi
else
  eval "$(gpgconf --launch gpg-agent)"
fi

# change capslock key to ctrl and vice versa
setxkbmap -option ctrl:swapcaps
# apply this to disable gnome from resetting the keyboard setting in X
# gsettings set org.gnome.settings-daemon.plugins.keyboard active false

setxkbmap -model pc105 -layout us,gr,de -option 'grp:shift_toggle'

# esc delay affects neomutt
export ESCDELAY=0

#
# setup paths
#

# add user path
_USER_PATH="${HOME}/bin/"
if [ -d "${_USER_PATH}" ]; then
  PATH="${_USER_PATH}":$PATH
fi

# add local path
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

# add golang path
_GOLANG_PATH="/usr/local/go/bin/"
if [ -d "${_GOLANG_PATH}" ]; then
  PATH="${_GOLANG_PATH}":$PATH
fi

_GOPATH=$(go env GOPATH)
if [ -d "${_GOPATH}" ]; then
  PATH="${_GOPATH}/bin":$PATH
fi

# add rust path
_RUSTLANG_PATH="${HOME}/.cargo/bin/"
if [ -d "${_RUSTLANG_PATH}" ]; then
  PATH="${_RUSTLANG_PATH}":$PATH
fi

# add cmake path
_CMAKE_PATH="/usr/local/cmake/bin/"
if [ -d "${_CMAKE_PATH}" ]; then
  PATH="${_CMAKE_PATH}":$PATH
fi

# add yarn path
_YARN_PATH1="$HOME/.yarn/bin:"
_YARN_PATH2="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
if [ -d "${_YARN_PATH1}" ]; then
  PATH="${_YARN_PATH1}":$PATH
fi
if [ -d "${_YARN_PATH2}" ]; then
  PATH="${_YARN_PATH2}":$PATH
fi

export PATH

# add java paths
JAVA_HOME=
JAVA_HOME_DEFAULT="/usr/lib/jvm/default-java"
if [ -d "${JAVA_HOME_DEFAULT}" ]; then
  JAVA_HOME="${JAVA_HOME_DEFAULT}"
fi
CLASSPATH=

export JAVA_HOME
export CLASSPATH

# setup pkg-config path
_PKG_CONFIG_PATHS=(
  /usr/share/pkgconfig
  /usr/lib/x86_64-linux-gnu/pkgconfig
  /usr/local/lib/pkgconfig
)
for p in "${_PKG_CONFIG_PATHS[@]}"; do
  if [ -d "${p}" ]; then
    PKG_CONFIG_PATH="${p}":$PKG_CONFIG_PATH
  fi
done
export PKG_CONFIG_PATH

# set editors
export EDITOR=$(which vim)
export CVSEDITOR=$(which vim)

if [ "${OPSYS_TYPE}" = "linux" ]; then
  export VISUAL=$(which gvim)
elif [ "${OPSYS_DISTRO}" = "apple" ]; then
  export VISUAL=$(which macvim)
fi

# unset dbus socket address
unset DBUS_SESSION_BUS_ADDRESS

# set up for android studio
export ANDROID_EMULATOR_FORCE_32BIT=true
