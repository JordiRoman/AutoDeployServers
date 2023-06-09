#!/bin/bash -x 

[ -f .env ] && source .env

DISK_SIZE=${DISK_SIZE:-10G}
HOST_NAME=${HOST_NAME:-sbd-server}

USERNAME=${USERNAME:-sid}

PASSWORD=${PASSWORD:-P4ssw0rd..}
CRYPT_PASSWORD=$(openssl passwd -6 ${PASSWORD} )

ISO_URL=${ISO_URL:-https://releases.ubuntu.com/22.04/ubuntu-22.04.2-live-server-amd64.iso}
ISO_FILE=$(basename $ISO_URL)

LOCAL_IP=$( hostname -I | awk '{print $1}' )
LOCAL_PORT=${LOCAL_PORT:-3003}

WORK_DIR=${WORK_DIR:-tmp}