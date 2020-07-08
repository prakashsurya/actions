#!/bin/bash -eux

PACKAGE="$1"
[[ -n "${PACKAGE}" ]] || exit 1

REPOSITORY=$(readlink -f "$PWD")
BRANCH=$(git rev-parse --abbrev-ref HEAD)

#
# To avoid any conflicts with the repository to be built and tested, we
# create a new directory to clone linux-pkg into, rather than cloning it
# directly into the workspace we're currently working within.
#
LINUXPKG=$(mktemp -d)
git clone --no-tags --depth 1 \
	https://github.com/delphix/linux-pkg.git "$LINUXPKG"

#
# The build assumes the APT cache is up-to-date, so we need to ensure we
# update it prior to running the build.
#
apt-get update

#
# By default, the build will fail unless it detects it's running in AWS
# and on an Ubuntu Bionic image. Thus, in order to run in the GitHub
# Action environment, we have to suppress this behavior.
#
export DISABLE_SYSTEM_CHECK=true

#
# The linux-pkg build logic does not support building from a previously
# checked-out repository, so we have to use the "-g" and "-b" options
# with "buildpkg.sh"; e.g. as opposed to having "buildpkg.sh" operate on
# the current directory, which contains the code we wish to build.
#
"$LINUXPKG/buildpkg.sh" -g "$REPOSITORY" -b "$BRANCH" "$PACKAGE"
