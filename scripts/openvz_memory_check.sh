#!/bin/bash

CTID=$1
METRIC=$2

case $METRIC in
    util)
        # Giả sử đây là lệnh để lấy memory utilization
        MEMORY_USAGE=$(vzctl exec $CTID cat /proc/meminfo | grep MemTotal | awk '{print $2}')
        echo $MEMORY_USAGE
        ;;
    putil)
        # Giả sử đây là lệnh để lấy memory utilization in percent
        MEMORY_USAGE_PERCENT=$(vzctl exec $CTID cat /proc/meminfo | grep MemTotal | awk '{print $2}')
        # Bạn cần tính toán để chuyển đổi sang phần trăm tùy theo logic của bạn
        echo $MEMORY_USAGE_PERCENT
        ;;
    *)
        echo "Unsupported metric"
        exit 1
        ;;
esac
