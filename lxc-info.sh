#!/bin/bash

HOSTNAME=$(hostname)

CTID=$(echo $1 | sed "s/${HOSTNAME}.//")

sudo /snap/bin/lxc info "$CTID"
