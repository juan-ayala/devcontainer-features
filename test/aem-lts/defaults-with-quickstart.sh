#!/bin/bash

set -e

source dev-container-features-test-lib

# Check options file created with defaults
source ${AEM_LTS_FEATURE_DIR}/options.sh
check "quickstartJar set" \
    echo "${AEM_LTS_QUICKSTART_JAR}" | grep -E "^/workspaces/[0-9]+/.devcontainer/mock-cq-quickstart-6\.6\.0\.jar$"
check "licenseCustomerName set" \
    [ "${AEM_LTS_LICENSE_CUSTOMER_NAME}" = "test-customer" ]
check "licenseDownloadId set" \
    [ "${AEM_LTS_LICENSE_DOWNLOAD_ID}" = "test-download-id" ]
check "author port default" \
    [ "${AEM_LTS_AUTHOR_PORT}" = "4502" ]
check "publish port default" \
    [ "${AEM_LTS_PUBLISH_PORT}" = "4503" ]

# Check aem-lts in PATH is executable
check "aem-lts is +x" \
    stat -c '%A' $(which aem-lts) | grep 'x.*x.*x'

test_runmode() {
    local service=$1 port=$2

    # Simulate a stale pid file (process exited but file was left behind)
    echo "99999" | sudo tee /tmp/aem-${service}.pid > /dev/null

    check "${service}: install & start" \
        aem-lts start ${service}
    check "${service}: wait for server started on port ${port}" \
        timeout 10 bash -c "until grep -q 'Server started on port ${port}' /var/log/aem-${service}.log 2>/dev/null; do sleep 0.5; done"
    check "${service}: compare pid file to java process" \
        [ $(cat /tmp/aem-${service}.pid) -eq $(pgrep -x java) ]
    check "${service}: stop" \
        aem-lts stop ${service}
    check "${service}: pid file should be removed" \
        [ ! -f /tmp/aem-${service}.pid ]
    check "${service}: no java process should be running" \
        [ -z $(pgrep -x java) ]

    # Test interactive mode: start in background, capture stdout, verify process runs, then kill it
    INTERACTIVE_LOG=$(mktemp)
    aem-lts start ${service} -i > ${INTERACTIVE_LOG} &
    INTERACTIVE_PID=$!
    check "${service}: interactive mode wait for server started on port ${port}" \
        timeout 10 bash -c "until grep -q 'Server started on port ${port}' ${INTERACTIVE_LOG} 2>/dev/null; do sleep 0.5; done"
    check "${service}: interactive mode pid matches java process" \
        [ $(pgrep -P ${INTERACTIVE_PID} -x java) -eq $(pgrep -x java) ]
    kill $(pgrep -P ${INTERACTIVE_PID} -x java) 2>/dev/null
    check "${service}: interactive mode java process stopped after kill" \
        timeout 10 bash -c "until ! pgrep -x java > /dev/null; do sleep 0.5; done"
    rm -f ${INTERACTIVE_LOG}
}

test_runmode author 4502
test_runmode publish 4503

reportResults
