#!/usr/bin/env bash

# create the feature directory
mkdir -p ${AEM_LTS_FEATURE_DIR}

# save feature properties
propertiesFile="${AEM_LTS_FEATURE_DIR}/options.sh"
echo "AEM_LTS_QUICKSTART_JAR=\"${QUICKSTARTJAR}\"" >> ${propertiesFile}
echo "AEM_LTS_LICENSE_CUSTOMER_NAME=\"${LICENSECUSTOMERNAME}\"" >> ${propertiesFile}
echo "AEM_LTS_LICENSE_DOWNLOAD_ID=\"${LICENSEDOWNLOADID}\"" >> ${propertiesFile}
echo "AEM_LTS_AUTHOR_PORT=\"${AUTHORPORT:-'4502'}\"" >> ${propertiesFile}
echo "AEM_LTS_PUBLISH_PORT=\"${PUBLISHPORT:-'4503'}\"" >> ${propertiesFile}
source ${propertiesFile}

# copy custom scripts
cp -r "$(dirname $0)/bin" ${AEM_LTS_FEATURE_DIR}
