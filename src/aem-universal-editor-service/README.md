
# Adobe Experience Manager Universal Editor Service (aem-universal-editor-service)

Setup the AEM Universal Editor Service for local development.

## Example Usage

```json
"features": {
    "ghcr.io/juan-ayala/devcontainer-features/aem-universal-editor-service:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| uesDownloadsDirectory | Path to directory that contains one or more UES zip files downloaded from Adobe's Software Distribution. | string | - |
| uesNodeVersion | Node.js version to use when running the Universal Editor Service. | string | 20 |
| uesVersion | Universal Editor Service version. | string | automatic |
| uesPort | Universal Editor Service port. | string | 8000 |
| authorHttpPort | HTTP port the AEM author is running on. | string | 4502 |
| authorHttpsPort | HTTPS port that should be proxied for the AEM author. | string | 44302 |

# Adding the Feature to a Project

## Pre-requisites
* Visual Studio Code
* Docker
* The AEM Universal Editor distribution

## Step 1: The Universal Editor Distribution
* [Download](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/developing/universal-editor/local-dev#install-ue-service) the AEM Universal Editor form Adobe's [Software Distribuition](https://experience.adobe.com/#/downloads) Site.
* Place the ZIP archive in your project folder (i.e. `.devcontainer/universal-editor-service-vprod-20240912200213.zip)

## Step 2: The Devcontainer Settings
* Add the following feature to the `.devcontainer/devcontainer.json` file
```jsonc
"features": {
    "ghcr.io/juan-ayala/devcontainer-features/aem-universal-editor-service:1": {
        "uesDownloadsDirectory": "${containerWorkspaceFolder}/.devcontainer"
    }
}
```

## Step 3: Visual Studio Code
* Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers). And open the project folder.
* VSCode will detect `.devcontainer/devcontainer.json`. And prompt you to reopen the project in a devcontainer.

## Run Universal Editor Service
In VSCode, open the terminal window. This is a terminal inside the docker container. You can run any command as needed, including Maven and Node.

There will be a script named `start-ues`.
* Start UES: `start-ues`

Once the service has started, verify you can get the core library. Make sure to accept the certificate errors for the self-signed certificate.
* https://localhost:8000/corslib/LATEST

## References
* [Local AEM Development with the Universal Editor](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/developing/universal-editor/local-dev#install-ue-service)

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/juan-ayala/devcontainer-features/blob/main/src/aem-universal-editor-service/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
