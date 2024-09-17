#!/usr/bin/env bash

# create the feature directory
mkdir -p ${AEM_UES_FEATURE_DIR}

# save feature properties
propertiesFile="${AEM_UES_FEATURE_DIR}/options.sh"
echo "AEM_UES_DOWNLOADS_DIR=\"${UESDOWNLOADSDIRECTORY}\"" >> ${propertiesFile}
echo "AEM_UES_NODE_VERSION=\"${UESNODEVERSION:-'20'}\"" >> ${propertiesFile}
echo "AEM_UES_VERSION=\"${UESVERSION:-'automatic'}\"" >> ${propertiesFile}
echo "AEM_UES_HTTP_PORT=\"${UESHTTPPORT:-'8001'}\"" >> ${propertiesFile}
echo "AEM_UES_HTTPS_PORT=\"${UESHTTPSPORT:-'8000'}\"" >> ${propertiesFile}
echo "AEM_UES_AUTHOR_HTTP_PORT=\"${AUTHORHTTPPORT:-'4502'}\"" >> ${propertiesFile}
echo "AEM_UES_AUTHOR_HTTPS_PORT=\"${AUTHORHTTPSPORT:-'44302'}\"" >> ${propertiesFile}
source ${propertiesFile}

# copy custom scripts
cp -r "$(dirname $0)/bin" ${AEM_UES_FEATURE_DIR}

if [ ! -f "${AEM_UES_FEATURE_DIR}/.env" ]; then
    cat <<EOF > "${AEM_UES_FEATURE_DIR}/.env"
UES_PORT=${AEM_UES_HTTP_PORT}
UES_TLS_REJECT_UNAUTHORIZED=false
EOF
fi