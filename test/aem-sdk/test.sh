#!/bin/bash
#
# To run this test only, add the --skip-scenarios flag.
#
# devcontainer features test \
#   --features aem-sdk \
#   --skip-scenarios \
#   --base-image mcr.microsoft.com/devcontainers/base
#

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.

# Check options file created with defaults
source ${AEM_SDK_FEATURE_DIR}/options.sh
check "sdk version default" \
    [ "${AEM_SDK_VERSION}" = "automatic" ]
check "sdks directory default" \
    [ "${AEM_SDK_SDKS_DIRECTORY}" = ".devcontainer" ]
check "author port default" \
    [ "${AEM_SDK_AUTHOR_PORT}" = "4502" ]
check "publish port default" \
    [ "${AEM_SDK_PUBLISH_PORT}" = "4503" ]
check "dispatcher port default" \
    [ "${AEM_SDK_DISPATCHER_PORT}" = "8080" ]
# Check setup scripts in PATH and executable
check "_globals is +x" \
    stat -c '%A' $(which _globals.sh) | grep 'x.*x.*x'
check "aem-sdk-setup-dispatcher is +x" \
    stat -c '%A' $(which aem-sdk-setup-dispatcher.sh) | grep 'x.*x.*x'
check "aem-sdk-setup-service is +x" \
    stat -c '%A' $(which aem-sdk-setup-service.sh) | grep 'x.*x.*x'
# Check instance jars and dispatcher run script not installed
check "no author jar" \
    [ ! -f "${AEM_SDK_FEATURE_DIR}/author/aem-author-p${AEM_SDK_AUTHOR_PORT}.jar" ]
check "no publish jar" \
    [ ! -f "${AEM_SDK_FEATURE_DIR}/publish/aem-publish-p${AEM_SDK_PUBLISH_PORT}.jar" ]
check "no dispatcher toos" \
    [ ! -d "${AEM_SDK_FEATURE_DIR}/dispatcher/bin" ]

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
