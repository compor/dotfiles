function filter_gone() {
  awk '$0 ~ "gone]" { print $1 }'
}

alias gitgone='git fetch --all --prune | git branch -vv | grep -v "\*" | grep -Ev "(\*|master|main)" | filter_gone '
