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

function get_sdk_directory()
{
    local directory="$(pwd)/${AEM_SDK_SDKS_DIRECTORY}"
    if [ -d ${directory} ]; then
        echo ${directory}
    else
        echo "$(pwd)/.devcontainer"
    fi
}

function get_aem_sdk_zip()
{
    local sdks_dir=$(get_sdk_directory)
    if [ "${AEM_SDK_VERSION}" = "automatic" ]; then
        echo "$(find ${sdks_dir}/aem-sdk-*.zip -maxdepth 0 -type f | sort -V | tail -n1)"
    else
        echo "${sdks_dir}/aem-sdk-${AEM_SDK_VERSION}.zip"
    fi
}

function add_line_to_shell_rc()
{
    echo "${1}" >> "${HOME}/.$(basename ${SHELL})rc"
}
