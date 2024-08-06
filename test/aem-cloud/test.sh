#!/bin/bash
#
# To run this test only, add the --skip-scenarios flag.
#
# devcontainer features test \
#   --features aem-cloud \
#   --skip-scenarios \
#   --base-image mcr.microsoft.com/devcontainers/base
#

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.

# Check options file created with defaults
source ${AEM_CLOUD_FEATURE_DIR}/options.sh
check "sdk version default" \
    [ "${AEM_CLOUD_VERSION}" = "automatic" ]
check "sdks directory default" \
    [ "${AEM_CLOUD_SDKS_DIRECTORY}" = ".devcontainer" ]
check "author port default" \
    [ "${AEM_CLOUD_AUTHOR_PORT}" = "4502" ]
check "publish port default" \
    [ "${AEM_CLOUD_PUBLISH_PORT}" = "4503" ]
check "dispatcher port default" \
    [ "${AEM_CLOUD_DISPATCHER_PORT}" = "8080" ]
# Check setup scripts installed
check "_globals is +x" \
    stat -c '%A' ${AEM_CLOUD_FEATURE_DIR}/scripts/_globals.sh | grep 'x.*x.*x'
check "setup-dispatcher is +x" \
    stat -c '%A' ${AEM_CLOUD_FEATURE_DIR}/scripts/setup-dispatcher.sh | grep 'x.*x.*x'
check "setup-service is +x" \
    stat -c '%A' ${AEM_CLOUD_FEATURE_DIR}/scripts/setup-service.sh | grep 'x.*x.*x'
# Check instance jars and dispatcher run script not installed
check "no author jar" \
    [ ! -f "${AEM_CLOUD_FEATURE_DIR}/author/aem-author-p${AEM_CLOUD_AUTHOR_PORT}.jar" ]
check "no publish jar" \
    [ ! -f "${AEM_CLOUD_FEATURE_DIR}/publish/aem-publish-p${AEM_CLOUD_PUBLISH_PORT}.jar" ]
check "no dispatcher toos" \
    [ ! -d "${AEM_CLOUD_FEATURE_DIR}/dispatcher/bin" ]

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
