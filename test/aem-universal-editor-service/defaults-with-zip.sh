#!/bin/bash

set -e

source dev-container-features-test-lib

# Check options file created with defaults
source ${AEM_UES_FEATURE_DIR}/options.sh
check "downloads directory set" \
    echo "${AEM_UES_DOWNLOADS_DIR}" | grep -E "^/workspaces/[0-9]+/.devcontainer$"
check "ues node version default" \
    [ "${AEM_UES_NODE_VERSION}" = "20" ]
check "ues version default" \
    [ "${AEM_UES_VERSION}" = "automatic" ]
check "ues port default" \
    [ "${AEM_UES_PORT}" = "8000" ]
check "ues port default" \
    [ "${AEM_UES_AUTHOR_HTTP_PORT}" = "4502" ]
check "ues port default" \
    [ "${AEM_UES_AUTHOR_HTTPS_PORT}" = "44302" ]

# Check that ues installs and exec the node script
check "can install & run ues" \
    bash -c "start-ues || true" | grep "hello, world"

reportResults
