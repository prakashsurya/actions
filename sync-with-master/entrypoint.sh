#!/bin/bash -eux

#
# This variable must be passed into this script.
#
BRANCH="$1"
[[ -n "${BRANCH}" ]] || exit 1

#
# We need these config parameters set in order to do the git-merge.
#
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

#
# Opening a pull request may fail if there already exists a pull request
# for the branch; e.g. if a previous pull request was previously made,
# but not yet merged by the time we run this "sync" script again. Thus,
# rather than causing the automation to report a failure in this case,
# we swallow the error and report success.
#
hub pull-request -b "${BRANCH}" -h "master" \
	-m "Merge branch 'master' into '${BRANCH}'" || true
