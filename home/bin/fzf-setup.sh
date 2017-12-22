# omit shebang

FZF_NAME="fzf"
FZF_DEST="${HOME}/.bash"
FZF_DIR="${FZF_DEST}/${FZF_NAME}"
FZF_URL="https://github.com/junegunn/${FZF_NAME}.git"

# attempt to install
if [ ! -d "$FZF_DIR" ]; then
  mkdir -p ${FZF_DEST}
  git clone ${FZF_URL} ${FZF_DIR}
  ${FZF_DIR}/install
fi

