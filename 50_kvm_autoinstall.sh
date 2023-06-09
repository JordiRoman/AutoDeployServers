#!/bin/bash -x 

source 00_config.sh

read -t 10 -p "en 10  segundos Lanzamos la autoinstalacion. <CTRL>+C para interrumpir "

[ ! -d ${WORK_DIR} ] && mkdir -p ${WORK_DIR}

# Descargamos ISO
if [ ! -f ${WORK_DIR}/${ISO_FILE} ] ; then
	curl -o ${WORK_DIR}/$(basename ${ISO_FILE} ) ${ISO_URL}
fi 

# Creamos el disco
[ -e ${WORK_DIR}/${HOSTNAME}.qcow2 ] && mv ${WORK_DIR}/${HOSTNAME}.qcow2 ${WORK_DIR}/${HOSTNAME}.qcow2.bak
qemu-img create -f qcow2 ${WORK_DIR}/${HOSTNAME}.qcow2 ${DISK_SIZE}

# Extraemos kernel & initrd Casper
[ -e ${WORK_DIR}/mnt ] && rm -rf ${WORK_DIR}/mnt

mkdir -p ${WORK_DIR}/mnt
7z -o${WORK_DIR}/mnt x ${WORK_DIR}/ubuntu-22.04.2-live-server-amd64.iso casper/vmlinuz casper/initrd
ls ${WORK_DIR}/mnt

# Lanzamos la autoinstall
time kvm -no-reboot -m 3072 \
	-drive file=${WORK_DIR}/${HOSTNAME}.qcow2,format=qcow2,cache=none,if=virtio \
	-cdrom ${WORK_DIR}/${ISO_FILE}					\
	-kernel ${WORK_DIR}/mnt/casper/vmlinuz				\
    -initrd ${WORK_DIR}/mnt/casper/initrd				\
    -append "autoinstall ds=nocloud-net;s=http://${LOCAL_IP}:${LOCAL_PORT}/"
