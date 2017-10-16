#!/bin/bash
source ./env
if [ ! $(docker ps -q -f name=${CONTAINER_NAME}) ]; then
    >&2 echo "Error: container is not running!"
    exit 1
fi

docker-compose exec ${CONTAINER_NAME} qtum-cli $*
