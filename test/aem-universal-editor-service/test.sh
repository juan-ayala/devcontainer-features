#!/bin/bash
#
# To run this test only, add the --skip-scenarios flag.
#
# devcontainer features test \
#   --features aem-universal-editor-service \
#   --skip-scenarios \
#   --base-image mcr.microsoft.com/devcontainers/base
#

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.

# Check options file created with defaults
source ${AEM_UES_FEATURE_DIR}/options.sh
check "downloads directory default" \
    [ -z "${AEM_UES_DOWNLOADS_DIR}" ]
check "ues node version default" \
    [ "${AEM_UES_NODE_VERSION}" = "20" ]
check "ues version default" \
    [ "${AEM_UES_VERSION}" = "automatic" ]
check "ues http port default" \
    [ "${AEM_UES_HTTP_PORT}" = "8001" ]
check "ues https port default" \
    [ "${AEM_UES_HTTPS_PORT}" = "8000" ]
check "author http port default" \
    [ "${AEM_UES_AUTHOR_HTTP_PORT}" = "4502" ]
check "author https port default" \
    [ "${AEM_UES_AUTHOR_HTTPS_PORT}" = "44302" ]
# Check start-ues in PATH is executable
check "start-ues is +x" \
    stat -c '%A' $(which start-ues) | grep 'x.*x.*x'
# Check .env file created
check "created .env" \
    [ -f "${AEM_UES_FEATURE_DIR}/.env" ]

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
