#!/usr/bin/env bash

source "$(dirname $0)/_globals.sh"

# extract the dispatcher install script
sdkzip=$(get_aem_sdk_zip)
[ -z ${sdkzip} ] && exit

sudo unzip -d ${AEM_SDK_FEATURE_DIR} ${sdkzip} 'aem-sdk-dispatcher-tools-*-unix.sh'
installscript="$(find ${AEM_SDK_FEATURE_DIR}/aem-sdk-dispatcher-tools-*-unix.sh -maxdepth 0 -type f | tail -n1)"

# run install script (in its directory)
sudo chmod a+x ${installscript}
cwd=$(dirname $0)
cd ${AEM_SDK_FEATURE_DIR}
sudo bash -c "${installscript}"
sudo rm ${installscript}
cd ${cwd}

# rename directory and add bin to PATH
sudo find ${AEM_SDK_FEATURE_DIR}/dispatcher-sdk-* -maxdepth 0 -type d -execdir mv {} dispatcher \;
add_line_to_shell_rc "export PATH=${PATH}:${AEM_SDK_FEATURE_DIR}/dispatcher/bin"

# alias to start dispatcher
add_line_to_shell_rc "alias start-dispatcher='cd dispatcher && ${AEM_SDK_FEATURE_DIR}/dispatcher/bin/docker_run.sh src host.docker.internal:${AEM_SDK_PUBLISH_PORT} ${AEM_SDK_DISPATCHER_PORT}'"
