#!/bin/bash -x 

source 00_config.sh

# arrancamos el servidor http
echo podemos iniciar la instalacion con el append 'autoinstall ds=nocloud-net\;s=http://${LOCAL_IP}:${LOCAL_PORT}/'

cd ${WORK_DIR}/www && xterm -e python3 -m http.server ${LOCAL_PORT} &

sleep 5 && links http://${LOCAL_IP}:${LOCAL_PORT}