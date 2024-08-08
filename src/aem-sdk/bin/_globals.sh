#!/usr/bin/env bash

source "${AEM_SDK_FEATURE_DIR}/options.sh"

function get_runmode_port()
{
    local runmode="${1}"
    if [ "${runmode}" = "publish" ]; then
        echo "${AEM_SDK_PUBLISH_PORT}"
    else
        echo "${AEM_SDK_AUTHOR_PORT}"
    fi
}

function get_runmode_jar()
{
    local runmode="${1}"
    local port=$(get_runmode_port ${runmode})
    echo "aem-${runmode}-p${port}.jar"
}

function get_aem_sdk_zip()
{
    local sdks_dir="${AEM_SDK_SDKS_DIRECTORY}"
    if [ ! -d ${sdks_dir} ]; then
        sdks_dir="$(pwd)"
    fi

    local sdk="${sdks_dir}/aem-sdk-${AEM_SDK_VERSION}.zip"
    if [ "${AEM_SDK_VERSION}" = "automatic" ]; then
        sdk="$(find ${sdks_dir}/aem-sdk-*.zip -maxdepth 0 -type f | sort -V | tail -n1)"        
    fi

    if [ ! -f "${sdk}" ]; then
        cat <<EOM
No AEM SDK found.
Search Path: ${sdks_dir}
Search Version: ${AEM_SDK_VERSION}
EOM
        exit 1
    else
        echo "${sdk}"
    fi
}
