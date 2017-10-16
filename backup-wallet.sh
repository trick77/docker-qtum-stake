#!/bin/bash -e
source ./env
if [ ! $(docker ps -q -f name=${CONTAINER_NAME}) ]; then
    >&2 echo "Error: container is not running!"
    exit 1
fi

if [ ! $(docker exec ${CONTAINER_NAME} qtum-cli getwalletinfo | grep -q unlocked_until )]; then
    >&2 echo "Error: wallet is not encrypted! Please encrypt your wallet before backing it up."
    exit 1
fi

mkdir -p ${BACKUP_DIR}
docker cp ${CONTAINER_NAME}:${DATA_DIR}/${WALLET_NAME} $BACKUP_PATH
echo "Wallet was saved to ${BACKUP_PATH}"
echo "Please make sure to backup your wallet to different mediums as well."
