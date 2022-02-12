# shellcheck shell=bash

function __bash_it_complete_pip3() {
  eval "$(pip3 completion --bash)"
  _pip_completion "$@"
}
complete -o default -F __bash_it_complete_pip3 pip3
