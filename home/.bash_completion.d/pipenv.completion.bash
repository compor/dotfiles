# shellcheck shell=bash
if [[ -x $(which pipenv) ]]; then
  eval "$(_PIPENV_COMPLETE=bash_source pipenv)"
fi
