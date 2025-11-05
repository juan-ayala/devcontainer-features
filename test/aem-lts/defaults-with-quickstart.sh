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

# Check that author installs, starts & stops correctly
check "author: install & start" \
    aem-lts start author
sleep 3 # give it time to start
check "author: check log for start message" \
    grep 'Server started on port 4502' /var/log/aem-author.log
check "author: compare pid file to java process" \
    [ $(cat /tmp/aem-author.pid) -eq $(pgrep -x java) ]
check "author: stop" \
    aem-lts stop author
sleep 3 # give it time to stop
check "author: pid file should be removed" \
    [ ! -f /tmp/aem-author.pid ]
check "author: no java process should be running" \
    [ -z $(pgrep -x java) ]

# Check that publish installs, starts & stops correctly
check "publish: install & start" \
    aem-lts start publish
sleep 3 # give it time to start
check "publish: check log for start message" \
    grep 'Server started on port 4503' /var/log/aem-publish.log
check "publish: compare pid file to java process" \
    [ $(cat /tmp/aem-publish.pid) -eq $(pgrep -x java) ]
check "publish: stop" \
    aem-lts stop publish
sleep 3 # give it time to stop
check "publish: pid file should be removed" \
    [ ! -f /tmp/aem-publish.pid ]
check "publish: no java process should be running" \
    [ -z $(pgrep -x java) ]

reportResults
