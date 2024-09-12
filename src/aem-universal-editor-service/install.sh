#!/usr/bin/env bash

# create the feature directory
mkdir -p ${AEM_UES_FEATURE_DIR}

# save feature properties
propertiesFile="${AEM_UES_FEATURE_DIR}/options.sh"
echo "AEM_UES_DOWNLOADS_DIR=\"${UESDOWNLOADSDIRECTORY}\"" >> ${propertiesFile}
echo "AEM_UES_VERSION=\"${UESVERSION:-'automatic'}\"" >> ${propertiesFile}
echo "AEM_UES_PORT=\"${UESPORT:-'8000'}\"" >> ${propertiesFile}
source ${propertiesFile}

# copy custom scripts
cp -r "$(dirname $0)/bin" ${AEM_UES_FEATURE_DIR}

# create .nvmrc file
echo "20" > "${AEM_UES_FEATURE_DIR}/.nvmrc"

# create ssl cert and private key
openssl req -newkey rsa:2048 -nodes -keyout "${AEM_UES_FEATURE_DIR}/key.pem" \
        -x509 -days 365 -out "${AEM_UES_FEATURE_DIR}/certificate.pem" -subj '/CN=localhost'

# create .env file
envfile="${AEM_UES_FEATURE_DIR}/.env"
echo "UES_PORT=${AEM_UES_PORT}" >> "${envfile}"
echo "UES_PRIVATE_KEY=./key.pem" >> "${envfile}"
echo "UES_CERT=./certificate.pem" >> "${envfile}"
echo "UES_TLS_REJECT_UNAUTHORIZED=false" >> "${envfile}"

