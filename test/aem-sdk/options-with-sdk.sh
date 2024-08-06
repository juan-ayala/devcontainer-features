#!/bin/bash

set -e

source dev-container-features-test-lib

# Check options file created with defaults
source ${AEM_SDK_FEATURE_DIR}/options.sh
check "sdk version default" \
    [ "${AEM_SDK_VERSION}" = "mock-2024.02.01" ]
check "sdks directory default" \
    [ "${AEM_SDK_SDKS_DIRECTORY}" = ".devcontainer/sdksfolder" ]
check "author port default" \
    [ "${AEM_SDK_AUTHOR_PORT}" = "3001" ]
check "publish port default" \
    [ "${AEM_SDK_PUBLISH_PORT}" = "3002" ]
check "dispatcher port default" \
    [ "${AEM_SDK_DISPATCHER_PORT}" = "8090" ]
# Check setup scripts installed
check "_globals is +x" \
    stat -c '%A' ${AEM_SDK_FEATURE_DIR}/scripts/_globals.sh | grep 'x.*x.*x'
check "setup-dispatcher is +x" \
    stat -c '%A' ${AEM_SDK_FEATURE_DIR}/scripts/setup-dispatcher.sh | grep 'x.*x.*x'
check "setup-service is +x" \
    stat -c '%A' ${AEM_SDK_FEATURE_DIR}/scripts/setup-service.sh | grep 'x.*x.*x'
# Check instance jars and dispatcher run script installed
check "author jar installed" \
    [ -f "${AEM_SDK_FEATURE_DIR}/author/aem-author-p${AEM_SDK_AUTHOR_PORT}.jar" ]
check "publish jar installed" \
    [ -f "${AEM_SDK_FEATURE_DIR}/publish/aem-publish-p${AEM_SDK_PUBLISH_PORT}.jar" ]
check "dispatcher tools installed" \
    [ -d "${AEM_SDK_FEATURE_DIR}/dispatcher/bin" ]
# Check aliases added can execute the mock files from the mock sdk
check "can run start-author mock" \
    bash -ci "start-author | grep 'hello, world'"
check "can run start-publish mock" \
    bash -ci "start-author | grep 'hello, world'"
check "can run start-dispatcher mock" \
    bash -ci "start-author | grep 'hello, world'"

reportResults
