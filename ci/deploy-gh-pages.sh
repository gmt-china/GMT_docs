#!/bin/bash
#
# Push HTML pages to the gh-pages branch of the current Github repository.
#
# Keeps pages built from git tags in separate folders (named after the tag).
# Pages for the master branch are in the 'dev' folder. 'latest' is a link to
# the last tag.

# To return a failure if any commands inside fail
set -e
set -x

REPO=$TRAVIS_REPO_SLUG
BRANCH=gh-pages
CLONE_DIR=deploy
CLONE_ARGS="--quiet --branch=$BRANCH --single-branch"
REPO_URL=https://${GH_TOKEN}@github.com/${REPO}.git
HTML_SRC=${TRAVIS_BUILD_DIR}/${HTML_BUILDDIR:-doc/_build/html}
# Place the HTML is different folders for different versions
if [[ "${TRAVIS_TAG}" != "" ]]; then
    VERSION=${TRAVIS_TAG}
else
    VERSION=${GMT_VERSION}
fi

echo -e "DEPLOYING HTML TO GITHUB PAGES:"
echo -e "Target: branch ${BRANCH} of ${REPO}"
echo -e "HTML source: ${HTML_SRC}"
echo -e "HTML destination: ${VERSION}"

# Clone the project, using the secret token.
# Uses /dev/null to avoid leaking decrypted key.
echo -e "Cloning ${REPO}"
git clone ${CLONE_ARGS} ${REPO_URL} ${CLONE_DIR} 2>&1 >/dev/null

cd ${CLONE_DIR}

# Configure git to a dummy Travis user
git config user.email "travis@nothing.com"
git config user.name "TravisCI"

# Delete all the files and replace with our new  set
echo -e "Remove old files from previous builds"
rm -rf ${VERSION}
cp -Rf ${HTML_SRC}/ ${VERSION}/
# Another copy to root directory
if [[ "${TRAVIS_BRANCH}" == 'master' ]]; then
    # copy files to root
    cp -Rf ${HTML_SRC}/* .
    # direct index.html to latest
    echo "<meta http-equiv=\"Refresh\" content=\"0;url=latest/\"/>" > index.html
fi

# Need to have this file so that Github doesn't try to run Jekyll
touch .nojekyll

# If this is a new release, update the link from /latest to the new release
if [[ "${TRAVIS_TAG}" != "" ]]; then
    echo -e "Setup link from ${VERSION} to 'latest'"
    rm -f latest
    ln -sf ${VERSION} latest
fi

echo -e "Add and commit changes"
git add -A .
git status
# If this is a dev build and the last commit was from a dev build, reuse the
# same commit
if [[ "${TRAVIS_TAG}" != "" && `git log -1 --format='%s'` == *"${GMT_VERSION}"* ]]; then
    echo -e "Amending last commit"
    git commit --amend --reset-author --no-edit
else
    # Make a new commit
    echo -e "Making a new commit"
    git commit -m "Deploy $VERSION from TravisCI"
fi

echo -e "Pushing..."
git push -fq origin $BRANCH 2>&1 >/dev/null

echo -e "Finished uploading generated files."

# Workaround for https://github.com/travis-ci/travis-ci/issues/6522
# Turn off exit on failure.
set +x
set +e
