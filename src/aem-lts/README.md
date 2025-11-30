
# Adobe Experience Manager LTS (aem-lts)

Setup author and publish services. Requires the AEM LTS quickstart jar and license details.

## Example Usage

```json
"features": {
    "ghcr.io/juan-ayala/devcontainer-features/aem-lts:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| quickstartJar | AEM LTS Quickstart Jar. | string | - |
| licenseCustomerName | AEM LTS License Customer Name. | string | - |
| licenseDownloadId | AEM LTS License Download Id. | string | - |
| authorPort | Author service port | string | 4502 |
| publishPort | Publish service port | string | 4503 |

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


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/juan-ayala/devcontainer-features/blob/main/src/aem-lts/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
