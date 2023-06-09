#!/bin/bash

source 00_config.sh

for comando in ssh-keygen envsubst qemu-img xterm python sleep links 7z kvm
do
	if [ -z "$(which ${comando})" ]; then
		echo "ERROR '${comando}' is not available."
		exit 1
	else
		echo "'${comando}' available."
	fi
done

[ ! -d ${WORK_DIR} ] && mkdir -p ${WORK_DIR}

echo "All commands availables."
