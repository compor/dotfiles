#!/usr/bin/env bash

# some info here
# https://wiki.ubuntu.com/CustomXSession

[[ -f ~/.Xresources ]] && xrdb -merge -I"${HOME}" ~/.Xresources

xinitdir="/etc/X11/xinit/xinitrc.d"
if [ -d "$xinitdir" ]; then
  for script in $xinitdir/*; do
    echo "Loading xinit script $script"
    if [ -x "$script" -a ! -d "$script" ]; then
      . "$script"
    fi
  done
fi

#exec i3
