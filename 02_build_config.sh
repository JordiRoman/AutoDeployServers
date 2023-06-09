#!/bin/bash -x 

source 00_config.sh

[ ! -d ${WORK_DIR} ] && mkdir -p ${WORK_DIR}

# Creamos la ssh key
if [ ! -e ${WORK_DIR}/key-${HOST_NAME}.pub ]; then
	ssh-keygen -t rsa -b 4096 -C "${HOST_NAME} ssh key" -f ${WORK_DIR}/key-${HOST_NAME} -N ${PASSWORD}
fi
SSH_PUB_KEY=$(cat ${WORK_DIR}/key-${HOST_NAME}.pub )

# creamos la configuracion
[ -e www ] && rm -rf www

mkdir -p ${WORK_DIR}/www
touch ${WORK_DIR}/www/meta-data
touch ${WORK_DIR}/www/vendor-data
export USERNAME PASSWORD CRYPT_PASSWORD SSH_PUB_KEY
cat user-data.tmpl | envsubst  > ${WORK_DIR}/www/user-data