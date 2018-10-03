#!/usr/bin/env bash

MOUNT_ROOT="${HOME}/remote"

REMOTE_HOST="melite"
REMOTE_DIR="/home/vasich/Dropbox"
LOCAL_MOUNT_DIR="Dropbox"

MOUNT_HOST_ROOT="${MOUNT_ROOT}/${REMOTE_HOST}"

mountpoint -q ${MOUNT_HOST_ROOT}/${LOCAL_MOUNT_DIR}/
if [[ $? == 0 ]]; then
  echo "Remote location already mounted. Unmounting..."
  fusermount -u ${MOUNT_HOST_ROOT}/${LOCAL_MOUNT_DIR}/
fi

sshfs ${REMOTE_HOST}:${REMOTE_DIR}/ ${MOUNT_HOST_ROOT}/${LOCAL_MOUNT_DIR}/

