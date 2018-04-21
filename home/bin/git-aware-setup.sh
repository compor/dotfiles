# omit shebang

if [ -n "$BASH_VERSION" ]; then
  GITAWAREPROMPT_NAME="git-aware-prompt"
  GITAWAREPROMPT_DEST="${HOME}/.bash"
  GITAWAREPROMPT_DIR="${GITAWAREPROMPT_DEST}/${GITAWAREPROMPT_NAME}"
  GITAWAREPROMPT_URL="https://github.com/joeytwiddle/${GITAWAREPROMPT_NAME}.git"

  # attempt to install
  if [ ! -d "$GITAWAREPROMPT_DIR" ]; then
    mkdir -p "${GITAWAREPROMPT_DEST}"
    git clone "${GITAWAREPROMPT_URL}" "${GITAWAREPROMPT_DIR}"
  fi

  # use if it exists
  if [ -d "$GITAWAREPROMPT_DIR" ]; then
    export GITAWAREPROMPT=${GITAWAREPROMPT_DIR}
    . "${GITAWAREPROMPT}/main.sh"
  fi
fi # BASH_VERSION
