#!/bin/bash

set -e

source dev-container-features-test-lib

# Check options file created with defaults
source ${AEM_SDK_FEATURE_DIR}/options.sh
check "sdks directory default" \
    echo "${AEM_SDK_SDKS_DIRECTORY}" | grep -E "^/workspaces/[0-9]+/.devcontainer$"
check "sdk version default" \
    [ "${AEM_SDK_VERSION}" = "automatic" ]
check "author port default" \
    [ "${AEM_SDK_AUTHOR_PORT}" = "4502" ]
check "publish port default" \
    [ "${AEM_SDK_PUBLISH_PORT}" = "4503" ]
check "dispatcher port default" \
    [ "${AEM_SDK_DISPATCHER_PORT}" = "8080" ]
# Check start-aem in PATH is executable
check "start-aem is +x" \
    stat -c '%A' $(which start-aem) | grep 'x.*x.*x'
# Check that author/publish/dispatcher installs and starts
check "can install & run author" \
    bash -c "start-aem author | grep 'hello, world'"
check "can install & run publish" \
    bash -c "start-aem publish | grep 'hello, world'"
check "can install & run dispatcher" \
    bash -c "start-aem dispatcher | grep 'All your base are belong to us'"

reportResults
