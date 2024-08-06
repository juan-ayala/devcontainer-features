#!/usr/bin/env bash

source "$(dirname $0)/_globals.sh"

# script args
runmode="${1}"

# extract and rename the quickstart jar
sdkzip=$(get_aem_sdk_zip)
[ -z ${sdkzip} ] && exit

runmodedir="${AEM_SDK_FEATURE_DIR}/${runmode}"
sudo unzip -d ${runmodedir} ${sdkzip} 'aem-sdk-quickstart-*.jar'
jar_file=$(get_runmode_jar ${runmode})
sudo find ${runmodedir}/aem-sdk-quickstart-*.jar -maxdepth 0 -type f -execdir mv {} ${jar_file} \;

# make user owner of crx-quickstart (it is a volume mount)
sudo chown ${USER} "${runmodedir}/crx-quickstart"

port=$(get_runmode_port ${runmode})
jvm_opts="-agentlib:\"jdwp=transport=dt_socket,address=*:3${port},server=y,suspend=n\""
cq_opts="-nofork -nobrowser -nointeractive"

# alias to start the instance
add_line_to_shell_rc "alias start-${runmode}='cd ${runmodedir} && java ${jvm_opts} -jar ${jar_file} ${cq_opts}'"
# alias to tail the error.log
add_line_to_shell_rc "alias tail-${runmode}='tail -f ${runmodedir}/crx-quickstart/logs/error.log'"
