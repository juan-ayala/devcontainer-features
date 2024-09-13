#!/usr/bin/env bash

# create the feature directory
mkdir -p ${AEM_UES_FEATURE_DIR}

# save feature properties
propertiesFile="${AEM_UES_FEATURE_DIR}/options.sh"
echo "AEM_UES_DOWNLOADS_DIR=\"${UESDOWNLOADSDIRECTORY}\"" >> ${propertiesFile}
echo "AEM_UES_NODE_VERSION=\"${UESNODEVERSION:-'20'}\"" >> ${propertiesFile}
echo "AEM_UES_VERSION=\"${UESVERSION:-'automatic'}\"" >> ${propertiesFile}
echo "AEM_UES_PORT=\"${UESPORT:-'8000'}\"" >> ${propertiesFile}
echo "AEM_UES_AUTHOR_HTTP_PORT=\"${AUTHORHTTPPORT:-'4502'}\"" >> ${propertiesFile}
echo "AEM_UES_AUTHOR_HTTPS_PORT=\"${AUTHORHTTPSPORT:-'44302'}\"" >> ${propertiesFile}
source ${propertiesFile}

# copy custom scripts
cp -r "$(dirname $0)/bin" ${AEM_UES_FEATURE_DIR}

# create ssl cert and private key
openssl req -newkey rsa:2048 -nodes -keyout "${AEM_UES_FEATURE_DIR}/key.pem" \
        -x509 -days 365 -out "${AEM_UES_FEATURE_DIR}/certificate.pem" -subj '/CN=localhost'
# and allow remote user to read private key
chgrp ${_REMOTE_USER} "${AEM_UES_FEATURE_DIR}/key.pem"
chmod g+r "${AEM_UES_FEATURE_DIR}/key.pem"

# create .env file
cat <<EOF >> "${AEM_UES_FEATURE_DIR}/.env"
UES_PORT=${AEM_UES_PORT}
UES_PRIVATE_KEY=./key.pem
UES_CERT=./certificate.pem
UES_TLS_REJECT_UNAUTHORIZED=false
EOF
