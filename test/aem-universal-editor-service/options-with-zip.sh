#!/bin/bash

set -e

source dev-container-features-test-lib

# Check options file created with defaults
source ${AEM_UES_FEATURE_DIR}/options.sh
check "downloads directory set" \
    echo "${AEM_UES_DOWNLOADS_DIR}" | grep -E "^/workspaces/[0-9]+/.devcontainer$"
check "ues version default" \
    [ "${AEM_UES_VERSION}" = "mock-2024.02.01" ]
check "ues port default" \
    [ "${AEM_UES_PORT}" = "9090" ]

# Check that ues installs and starts
check "can install & run ues" \
    start-ues | grep "hello, world"

reportResults
