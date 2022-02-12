# shellcheck shell=bash

if [[ -x $(which register-python-argcomplete) ]]; then
  eval "$(register-python-argcomplete conda)"
else
  echo "Argcomplete not found. Please run 'conda install argcomplete'" >>/tmp/bash_completions.log
fi
