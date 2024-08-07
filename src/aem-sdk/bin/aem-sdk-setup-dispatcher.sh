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

# rename directory
sudo find ${AEM_SDK_FEATURE_DIR}/dispatcher-sdk-* -maxdepth 0 -type d -execdir mv {} dispatcher \;
