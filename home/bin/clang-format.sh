#!/usr/bin/env bash

TOOL_NAME='clang-format'

mapfile -t LOCATIONS < ${HOME}/.clang-format-locations.txt


for LOC in ${LOCATIONS[@]}; do 
  TOOL="${LOC}/${TOOL_NAME}"

  if [ -e "${TOOL}" ]; then 
    LIB_PATH="${LOC}/../lib/"

    break
  fi
done

LD_LIBRARY_PATH="${LIB_PATH}" ${TOOL} "${@}"

