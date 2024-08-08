#!/usr/bin/env bash

source "$(dirname $0)/_globals.sh"

# script args
runmode="${1}"

# extract and rename the quickstart jar
sdkzip=$(get_aem_sdk_zip)

runmodedir="${AEM_SDK_FEATURE_DIR}/${runmode}"
sudo unzip -d ${runmodedir} ${sdkzip} 'aem-sdk-quickstart-*.jar'
jar_file=$(get_runmode_jar ${runmode})
sudo find ${runmodedir}/aem-sdk-quickstart-*.jar -maxdepth 0 -type f -execdir mv {} ${jar_file} \;

# make user owner of crx-quickstart (it is a volume mount)
sudo chown ${USER} "${runmodedir}/crx-quickstart"
