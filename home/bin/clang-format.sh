#!/usr/bin/env bash

TOOL_NAME='clang-format'

mapfile -t LOCATIONS < ${HOME}/.clang-format-locations.txt


for LOC in ${LOCATIONS[@]}; do 
  LOC_NORM=$(dirname ${LOC})
  TOOL="${LOC_NORM}/${TOOL_NAME}"

  if [ -e "${TOOL}" ]; then 
    LIB_PATH="${LOC_NORM}/../lib/"

    break
  fi
done

LD_LIBRARY_PATH="${LIB_PATH}" ${TOOL} "${@}"

