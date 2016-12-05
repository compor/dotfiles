#!/usr/bin/env bash 

TOOL_NAME='clang-format'

LOCATIONS=(
  '/bulk/workbench/llvm/base/3.7/toolchain1/bin/'
  )


for loc in ${LOCATIONS}; do 
  if [ -e "${loc}" ]; then 
    TOOL="${loc}/${TOOL_NAME}"
    LIB_PATH="${loc}/../lib/"
  fi
done


LD_LIBRARY_PATH="${LIB_PATH}" ${TOOL} "${@}"

