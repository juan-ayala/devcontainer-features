#!/bin/bash
#
# To run this test only, add the --skip-scenarios flag.
#
# devcontainer features test \
#   --features aem-repo-tool \
#   --skip-scenarios \
#   --base-image mcr.microsoft.com/devcontainers/base
#

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.

check "execute repo with --help flag" \
    repo --help | cat - | grep Usage:

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
