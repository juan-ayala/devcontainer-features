#!/usr/bin/env bash

source "$(dirname $0)/_globals.sh"

sdkzip=$(get_aem_sdk_zip) || aem_sdk_not_found

# extract the dispatcher install script
sudo unzip -d ${AEM_SDK_FEATURE_DIR} ${sdkzip} 'aem-sdk-dispatcher-tools-*-unix.sh'
installscript="$(find ${AEM_SDK_FEATURE_DIR} -maxdepth 1 -iname 'aem-sdk-dispatcher-tools-*-unix.sh' -type f | tail -n1)"

# run install script (in its directory)
sudo chmod a+x ${installscript}
cwd=$(dirname $0)
cd ${AEM_SDK_FEATURE_DIR}
sudo bash -c "${installscript}"
sudo rm ${installscript}
cd ${cwd}

# rename directory
sudo find ${AEM_SDK_FEATURE_DIR} -maxdepth 1 -iname 'dispatcher-sdk-*' -type d -execdir mv {} dispatcher \;
