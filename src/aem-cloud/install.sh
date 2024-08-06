#!/usr/bin/env bash

# create the feature directory
mkdir -p ${AEM_CLOUD_FEATURE_DIR}

# save feature properties
propertiesFile="${AEM_CLOUD_FEATURE_DIR}/options.sh"
echo "AEM_CLOUD_VERSION=\"${SDKVERSION:-'automatic'}\"" >> ${propertiesFile}
echo "AEM_CLOUD_SDKS_DIRECTORY=\"${SDKSDIRECTORY:-'.devcontainer'}\"" >> ${propertiesFile}
echo "AEM_CLOUD_AUTHOR_PORT=\"${AUTHORPORT:-'4502'}\"" >> ${propertiesFile}
echo "AEM_CLOUD_PUBLISH_PORT=\"${PUBLISHPORT:-'4503'}\"" >> ${propertiesFile}
echo "AEM_CLOUD_DISPATCHER_PORT=\"${DISPATCHERPORT:-'8080'}\"" >> ${propertiesFile}
source ${propertiesFile}

# copy custom scripts
cp -r "$(dirname $0)/scripts" ${AEM_CLOUD_FEATURE_DIR}
#find "${AEM_CLOUD_FEATURE_DIR}/scripts" -name "*.sh" -exec chmod +x {} \;
