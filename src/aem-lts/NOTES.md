# Adding the Feature to a Project

## Pre-requisites
* Visual Studio Code
* Docker
* The AEM LTS Quickstart Jar

## Step 1: The SDK Archive
* Navigate to Adobe's [Software Distribuition](https://experience.adobe.com/#/downloads) Site. Click on [Adobe Experience Manager](https://experience.adobe.com/#/downloads/content/software-distribution/en/aem.html). And click on [Download AEM 6.5 LTS](https://experience.adobe.com/#/downloads/content/software-distribution/en/aem.html?package=/content/software-distribution/en/details.html/content/dam/aem/public/adobe/packages/cq660/quickstart/cq-quickstart-6.6.0.jar)
* Place the JAR file in your project folder (i.e. `.devcontainer/cq-quickstart-6.6.0.jar`)

## Step 2: The Devcontainer Settings
* Add the following feature to the `.devcontainer/devcontainer.json` file
```jsonc
"features": {
    "ghcr.io/juan-ayala/devcontainer-features/aem-lts:1": {
            "quickstartJar": "${containerWorkspaceFolder}/.devcontainer/cq-quickstart-6.6.0.jar",
            "licenseCustomerName": "Acme Corporation",
            "licenseDownloadId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }
}
```

## Step 3: Visual Studio Code
* Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers). And open the project folder.
* VSCode will detect `.devcontainer/devcontainer.json`. And prompt you to reopen the project in a devcontainer.

## Run AEM Services
In VSCode, open the terminal window. This is a terminal inside the docker container. You can run any command as needed, including Maven and Node.

There will be a script named `aem-lts`. Use this to start the author, publish or dispatcher.
* Start author: `aem-lts start author`
* Stop author: `aem-lts stop author`
* Start publish: `aem-lts start publish`
* Stop publish: `aem-lts stop publish`

The feature also sets up volume mounts for the author and publish services. This is where the services will persist the repository. So that if the container gets deleted and/or rebuilt, the repository will persist.

## References
* [Install local AEM Instances](https://experienceleague.adobe.com/en/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment#install-local-aem-instances)
