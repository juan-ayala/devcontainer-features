# GitHub Copilot Instructions - devcontainer-features

## Repository role
You are working in a Dev Container Features repository that packages Adobe Experience Manager (AEM) tooling for local development. The repository is centered on feature definitions under src/<feature-id>/, test fixtures under test/<feature-id>/, and CI workflows under .github/workflows/.

## Repository-specific conventions
- Feature IDs and folder names match exactly:
  - aem-sdk
  - aem-lts
  - aem-repo-tool
  - aem-universal-editor-service
- Each feature owns its own install.sh, devcontainer-feature.json, and supporting scripts under src/<feature-id>/bin/.
- Test directories mirror the feature IDs under test/<feature-id>/ and contain at least test.sh plus scenario definitions when applicable.
- Generated documentation for each feature is stored in src/<feature-id>/README.md and is derived from devcontainer-feature.json. Do not manually diverge from the JSON unless you intentionally want to change the generated output.

## Feature implementation conventions
### devcontainer-feature.json
- Keep the JSON compliant with Dev Container Features Spec v1.
- Preserve existing option names and defaults when making incremental changes.
- Any new option must be documented in the options block and reflected in install.sh and, when relevant, in tests and scenarios.
- Preserve the existing containerEnv PATH entries and feature directories:
  - aem-sdk: PATH includes /aem-sdk/bin:/aem-sdk/dispatcher/bin:${PATH}
  - aem-lts: PATH includes /aem-lts/bin:/aem-lts/dispatcher/bin:${PATH}
  - aem-repo-tool: PATH includes /aem-repo-tool:${PATH}
  - aem-universal-editor-service: PATH includes /aem-ues/bin:${PATH}
- Preserve existing mounts where applicable. For example, aem-sdk and aem-lts mount persistent author/publish volumes under their feature directories.
- Keep dependsOn and installsAfter entries when a feature relies on Java, Docker-in-Docker, or Node.

### install.sh
- Use /usr/bin/env bash as the shebang.
- Create the feature directory with mkdir -p and write options.sh in the feature root.
- Persist feature configuration by exporting values into options.sh and sourcing it immediately after creation.
- Copy the feature-specific bin scripts into the feature directory with cp -r.
- Use idempotent logic and avoid re-downloading or re-extracting unless necessary.
- Prefer explicit validation for required inputs and fail fast when required artifacts are missing.
- Clean up temporary archives when you create them during the same layer execution.

### bin scripts
- Source the feature options file from the feature directory.
- Use helper functions for repeated logic instead of duplicating path and lookup code.
- Follow the current naming and behavior patterns already used in this repository:
  - aem-sdk: get_runmode_port, get_runmode_jar, get_aem_sdk_zip, aem_sdk_not_found
  - aem-lts: get_runmode_port, get_action, get_runmode, aem_lts_err
  - aem-universal-editor-service: get_ues_zip, ues_zip_not_found
- Keep command entrypoints consistent with the current user-facing commands:
  - start-aem author|publish|dispatcher
  - start-ues
  - aem-lts start|stop author|publish [-i]

## Feature-specific behavior to preserve
### aem-sdk
- The feature installs SDK artifacts into /aem-sdk and exposes the start-aem command.
- start-aem must auto-install the requested service jar or dispatcher tools on first use.
- The feature expects the AEM SDK archive in a local directory, usually .devcontainer, and supports automatic version selection via sdkVersion=automatic.
- Persisted state must live in the mounted volume paths under /aem-sdk/author/crx-quickstart and /aem-sdk/publish/crx-quickstart.

### aem-lts
- The feature copies the provided quickstart jar into the feature directory and generates license.properties from the configured license values.
- The aem-lts script should support start and stop actions for author and publish.
- Interactive mode must run in the foreground, while non-interactive mode should daemonize and write logs to /var/log/aem-<runmode>.log.
- Keep the current defaults for authorPort and publishPort.

### aem-repo-tool
- The repo tool is fetched from the Adobe-Marketing-Cloud tools release endpoint.
- The feature installs the binary at /aem-repo-tool/repo and makes it executable.
- Do not introduce extra packaging or download logic unless the upstream release path changes.

### aem-universal-editor-service
- The feature expects one or more Universal Editor Service zip files in a local directory, usually .devcontainer.
- start-ues must source NVM, install the configured Node version, install required global packages, and then launch the service plus local SSL proxies.
- The feature also provisions the content package into the AEM author install directory when aem-sdk is present.

## Testing and validation workflow
- Use the same commands already encoded in the GitHub Actions workflows under .github/workflows/.
- Validate feature JSON files with the devcontainers action:
  - devcontainers/action@v1 with validate-only: true and base-path-to-features: ./src
- Run generated tests for a specific feature against a base image:
  - devcontainer features test --skip-scenarios -f <feature-id> -i <base-image> .
- Run scenario-based tests for a feature:
  - devcontainer features test -f <feature-id> --skip-autogenerated --skip-duplicated .
- When changing a feature, update or add test.sh and scenario definitions under test/<feature-id>/ if the change affects behavior or options.

## Documentation and examples
- Update feature README.md and NOTES.md when user-facing behavior changes.
- Use the existing documentation patterns in the repository:
  - Example usage with ghcr.io/juan-ayala/devcontainer-features/<feature-id>:1
  - A .devcontainer/devcontainer.json snippet that points the feature to ${containerWorkspaceFolder}/.devcontainer
  - Run instructions showing the exact command the user should execute inside the devcontainer
- Keep examples consistent with the current feature IDs and option names.
- Treat README.md as generated output when feasible; prefer changing devcontainer-feature.json and letting the existing release workflow regenerate it.

## General implementation guidance
- Prefer portable Bash and avoid shell-specific behavior that is not already used in the repository.
- Preserve the current project style: minimal scripts, direct environment usage, and explicit path handling.
- Make every change idempotent and safe to rerun.
- When adding new logic, prefer the smallest change that matches the existing patterns in neighboring feature scripts.
- If a change affects how users configure or run a feature, update both the feature JSON and the user-facing documentation.

## What to check before you claim completion
- Verify the relevant feature JSON remains valid.
- Run the appropriate test command for the changed feature.
- If the change affects user-facing commands or options, confirm the test or scenario coverage includes that behavior.
- If the change touches shared conventions, re-check the affected feature directories and any generated README output.
