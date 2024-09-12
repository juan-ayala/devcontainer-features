#!/usr/bin/env bash

# create the feature directory
mkdir -p ${AEM_REPO_TOOL_FEATURE_DIR}

REPO_TOOL_RELEASE="https://github.com/Adobe-Marketing-Cloud/tools/releases/download/repo-${REPOTOOLVERSION:-'1.4'}/repo"

curl --location ${REPO_TOOL_RELEASE} --output "${AEM_REPO_TOOL_FEATURE_DIR}/repo"
chmod +x "${AEM_REPO_TOOL_FEATURE_DIR}/repo"
