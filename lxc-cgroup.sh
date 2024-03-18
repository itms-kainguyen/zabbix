#!/bin/bash

# Lấy hostname và ID của container từ đối số
HOSTNAME=$(hostname)
CTID=$(echo $1 | sed "s/${HOSTNAME}.//")

# Xác định đường dẫn của cgroup
CGROUP_PATH="/sys/fs/cgroup"
CONTAINER_CGROUP="lxc.payload.${CTID}"

# Kiểm tra và đọc giá trị từ cgroup
if [[ -d "${CGROUP_PATH}/${CONTAINER_CGROUP}" ]]; then
    CAT_PATH="${CGROUP_PATH}/${CONTAINER_CGROUP}/$2"
    if [[ -e "${CAT_PATH}" ]]; then
        cat "${CAT_PATH}"
    else
        echo "Error: ${CAT_PATH} does not exist" >&2
        exit 1
    fi
else
    echo "Error: Container cgroup directory does not exist" >&2
    exit 1
fi
