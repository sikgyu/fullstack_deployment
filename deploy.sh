#!/usr/bin/bash

set -uxe 

source helpers.sh

SSH_CMD="ssh -i ${SSH_KEY_FILE} -p ${SSH_PORT} ${SSH_USER}@${TARGET} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
SCP_CMD="scp -i ${SSH_KEY_FILE} -P ${SSH_PORT} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
SCP_DEST="${SSH_USER}@${TARGET}:"

$SCP_CMD deploy_backend.sh $SCP_DEST 
$SCP_CMD deploy_frontend.sh $SCP_DEST

$SCP_CMD -r files/ $SCP_DEST

$SSH_CMD bash deploy_backend.sh
$SSH_CMD << EOSSH
    sudo cp /home/admin/files/backend/deploy.service /etc/systemd/system/deploy.service
    sudo systemctl daemon-reload
    sudo systemctl enable deploy
    sudo systemctl start deploy
    sudo systemctl restart nginx 
EOSSH

$SSH_CMD bash deploy_frontend.sh
