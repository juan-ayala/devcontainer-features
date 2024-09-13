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
check "sdk version default" \
    [ "${AEM_UES_VERSION}" = "automatic" ]
# Check start-ues in PATH is executable
check "start-ues is +x" \
    stat -c '%A' $(which start-ues) | grep 'x.*x.*x'
# Check config files created
check "created .nvmrc" \
    [ -f "${AEM_UES_FEATURE_DIR}/.nvmrc" ]
check "can read key" \
    stat -c '%a' "${AEM_UES_FEATURE_DIR}/key.pem" | grep 640
check "key group set to remote user" \
    stat -c '%G' "${AEM_UES_FEATURE_DIR}/key.pem" | grep "${_REMOTE_USER}"
check "created certificate" \
    [ -f "${AEM_UES_FEATURE_DIR}/certificate.pem" ]
check "created .env" \
    [ -f "${AEM_UES_FEATURE_DIR}/.env" ]

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
