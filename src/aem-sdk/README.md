
# Adobe Experience Manager SDK (aem-sdk)

Setup author and publish services. And the dispatcher tools. Requires the AEM as a Cloud Service SDK.

## Example Usage

```json
"features": {
    "ghcr.io/juan-ayala/devcontainer-features/aem-sdk:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| sdksDirectory | Path to directory that contains one or more SDKs. | string | - |
| sdkVersion | AEM SDK Version that will be retreived from the SDKs directory. | string | automatic |
| authorPort | Author service port | string | 4502 |
| publishPort | Publish service port | string | 4503 |
| dispatcherPort | Dispatcher port | string | 8080 |

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

## Run AEM Services
In VSCode, open the terminal window. This is a terminal inside the docker container. You can run any command as needed, including Maven and Node.

There will be a script named `start-aem`. Use this to start the author, publish or dispatcher.
* Start author: `start-aem author`
* Start publish: `start-aem publish`
* Start dispatcher: `start-aem dispatcher`

The feature also sets up volume mounts for the author and publish services. This is where the services will persist the repository. So that if the container gets deleted and/or rebuilt, the repository will persist.

## References
* [Set up local AEM SDK](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime)
* [Set up local Dispatcher Tools](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/dispatcher-tools)

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/juan-ayala/devcontainer-features/blob/main/src/aem-sdk/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
