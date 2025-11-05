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
source ${AEM_LTS_FEATURE_DIR}/options.sh
check "quickstartJar default" \
    [ -z "${AEM_LTS_QUICKSTART_JAR}" ]
check "licenseCustomerName default" \
    [ -z "${AEM_LTS_LICENSE_CUSTOMER_NAME}" ]
check "licenseDownloadId default" \
    [ -z "${AEM_LTS_LICENSE_DOWNLOAD_ID}" ]
check "authorPort default" \
    [ "${AEM_LTS_AUTHOR_PORT}" = "4502" ]
check "publishPort default" \
    [ "${AEM_LTS_PUBLISH_PORT}" = "4503" ]
# Check start-aem in PATH is executable
check "aem-lts is +x" \
    stat -c '%A' $(which aem-lts) | grep 'x.*x.*x'
# Check instance jars and dispatcher run script not installed
check "no author jar" \
    [ ! -f "${AEM_LTS_FEATURE_DIR}/author/${AEM_LTS_QUICKSTART_JAR}.jar" ]
check "no publish jar" \
    [ ! -f "${AEM_LTS_FEATURE_DIR}/publish/${AEM_LTS_QUICKSTART_JAR}.jar" ]

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
