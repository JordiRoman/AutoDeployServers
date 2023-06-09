#!/bin/bash -x 

source 00_config.sh

echo "iniciamos la maquina final (se lanza 2 veces)"

for i in 1 2
do
	kvm -no-reboot -m 2048 		\
		-drive file=${WORK_DIR}/${HOST_NAME}.qcow2,format=qcow2,cache=none,if=virtio
done
