# Adding the Feature to a Project

## Pre-requisites
* Visual Studio Code
* Docker
* The AEM SDK

## Step 1: The SDK Archive
* [Download](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime#download-the-aem-as-a-cloud-service-sdk) the AEM SDK form Adobe's [Software Distribuition](https://experience.adobe.com/#/downloads) Site.
* Place the ZIP archive in your project folder (i.e. `.devcontainer/aem-sdk-2024.4.15977.20240418T174835Z-240400.zip)

## Step 2: The Devcontainer Settings
* Add the following feature to the `.devcontainer/devcontainer.json` file
```jsonc
"features": {
    "ghcr.io/juan-ayala/devcontainer-features/aem-sdk:1": {}
}
```

## Step 3: Visual Studio Code
* Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers). And open the project folder.
* VSCode will detect `.devcontainer/devcontainer.json`. And prompt you to reopen the project in a devcontainer.
* After the container gets created, the feature will run the setup scripts. They will create the folder structure for an author and publish service. And unpack the dispatcher tools.

## Run AEM Services
In VSCode, open the terminal window. This is a terminal inside the docker container. You can run any command as needed, including Maven and Node.

Additionally, the feature will have added some helpful aliases
* `start-author`
* `start-publish`
* `start-dispatcher`

The feature also sets up volume mounts for the author and publish services. This is where the services will persist the repository. So that if the container gets deleted and/or rebuilt, the repository will persist.

## References
* [Set up local AEM SDK](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime)
* [Set up local Dispatcher Tools](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/dispatcher-tools)