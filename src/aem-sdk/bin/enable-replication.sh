#!/usr/bin/env bash

source "$(dirname $0)/_globals.sh"

curl -u admin:admin --output /dev/null --silent \
     -X POST \
     -F enabled='true' \
     -F userId='' \
     -F transportUri="http://localhost:${AEM_SDK_PUBLISH_PORT}/bin/receive?sling:authRequestLogin=1" \
     -F transportUser='admin' \
     -F transportPassword='admin' \
     http://localhost:${AEM_SDK_AUTHOR_PORT}/etc/replication/agents.author/publish/jcr:content

curl -u admin:admin \
     -X GET \
     http://localhost:${AEM_SDK_AUTHOR_PORT}/etc/replication/agents.author/publish.test.html
