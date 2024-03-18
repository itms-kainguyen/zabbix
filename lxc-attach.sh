#!/bin/bash

# Thêm đường dẫn đến thư mục chứa lxc-info vào biến PATH
export PATH="$PATH:/snap/bin"

if [[ -z $2 ]]; then
    COMMAND="df"
else
    COMMAND=$2
fi

HOSTNAME=$(hostname)
CTID=$(echo $1 | sed "s/${HOSTNAME}.//")

# Kiểm tra xem lệnh lxc-info có tồn tại không
if ! command -v lxc &> /dev/null
then
    echo "lxc command not found. Make sure LXD is installed and lxc is in the PATH."
    exit 1
fi

STATUS=$(sudo lxc info $CTID | grep Status | awk '{print $2}')

if [[ $STATUS = "STOPPED" ]]; then
    exit 0
fi

case $COMMAND in
"df")
    sudo lxc exec $CTID -- df -P / 2>/dev/null || \
    sudo lxc exec $CTID -- /bin/df -P / 2>/dev/null
    ;;
"dfi")
    sudo lxc exec $CTID -- df -i -P / 2>/dev/null || \
    sudo lxc exec $CTID -- /bin/df -i -P / 2>/dev/null
    ;;
esac
