#!/usr/bin/env bash

source "$(dirname $0)/_globals.sh"

# script args
runmode="${1}"

sdkzip=$(get_aem_sdk_zip) || aem_sdk_not_found

# extract and rename the quickstart jar
runmodedir="${AEM_SDK_FEATURE_DIR}/${runmode}"
sudo unzip -d ${runmodedir} ${sdkzip} 'aem-sdk-quickstart-*.jar'
jar_file=$(get_runmode_jar ${runmode})
sudo find ${runmodedir} -maxdepth 1 -iname 'aem-sdk-quickstart-*.jar' -type f -execdir mv {} ${jar_file} \;

# make user owner of crx-quickstart (it is a volume mount)
sudo chown ${USER} "${runmodedir}/crx-quickstart"
