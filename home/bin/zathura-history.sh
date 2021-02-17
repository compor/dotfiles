#!/bin/bash

HISTORY_FILE="${HOME}/.local/share/zathura/history"

OPTIONS='-columns 1 -width 100 -lines 15 -bw 2 -yoffset -2 -location 1'

SELECTED=$(cat "${HISTORY_FILE}" | grep -Po '\[\K[^\]]*' |
  rofi -dmenu -i -markup-rows "${OPTIONS}")

[[ -z ${SELECTED} ]] && exit

zathura "${SELECTED}"

exit 0
