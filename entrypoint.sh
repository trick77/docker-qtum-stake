#!/bin/bash -e
mkdir -p ${DATA_DIR}
if [[ ! -s ${DATA_DIR} ]]; then
    cat <<EOF > ${DATA_DIR}/qtum.conf
printtoconsole=1
rpcallowip=::/0
rpcpassword=${QTUM_RPC_PASSWORD:-password}
rpcuser=${QTUM_RPC_USER:-qtum}
EOF

fi

exec "$@"
