#!/usr/bin/env bash

# create the feature directory
mkdir -p ${AEM_SDK_FEATURE_DIR}

# save feature properties
propertiesFile="${AEM_SDK_FEATURE_DIR}/options.sh"
echo "AEM_SDK_VERSION=\"${SDKVERSION:-'automatic'}\"" >> ${propertiesFile}
echo "AEM_SDK_SDKS_DIRECTORY=\"${SDKSDIRECTORY:-'.devcontainer'}\"" >> ${propertiesFile}
echo "AEM_SDK_AUTHOR_PORT=\"${AUTHORPORT:-'4502'}\"" >> ${propertiesFile}
echo "AEM_SDK_PUBLISH_PORT=\"${PUBLISHPORT:-'4503'}\"" >> ${propertiesFile}
echo "AEM_SDK_DISPATCHER_PORT=\"${DISPATCHERPORT:-'8080'}\"" >> ${propertiesFile}
source ${propertiesFile}

# copy custom scripts
cp -r "$(dirname $0)/bin" ${AEM_SDK_FEATURE_DIR}
