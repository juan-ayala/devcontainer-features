#!/usr/bin/env bash

source "${AEM_LTS_FEATURE_DIR}/options.sh"

function get_runmode_port()
{
    local runmode="${1}"
    if [ "${runmode}" = "publish" ]; then
        echo "${AEM_LTS_PUBLISH_PORT}"
    else
        echo "${AEM_LTS_AUTHOR_PORT}"
    fi
}

function aem_lts_err()
{
    echo "${1}" >&2
    exit 42
}

get_action() {
    [ "${1}" = 'start' ] && action="${1}"
    [ "${1}" = 'stop' ] && action="${1}"
    [ -z "${action}" ] && action="start"
    echo "${action}"
}

get_runmode() {
    [ "${1}" = 'author' ] && service="${1}"
    [ "${1}" = 'publish' ] && service="${1}"
    [ -z "${service}" ] && service="author"
    echo "${service}"
}
