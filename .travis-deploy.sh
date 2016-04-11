#!/bin/bash
#
# Deploy master branch only
#
#  TRAVIS_BRANCH:
#   - triggered by commit => the name of the branch currently being built
#   - triggered by a PR => the name of the branch targeted by the pull request
#  TRAVIS_PULL_REQUEST:
#   - is a pull request => pull request number
#   - not a pull request => false

if [ ${TRAVIS_BRANCH} = "master" -a ${TRAVIS_PULL_REQUEST} = 'false' ]; then
    echo "In master branch, deploying now..."
    git config user.name "Dongdong Tian"
    git config user.email "seisman.info@gmail.com"
    # Deploy Github Pages
    ghp-import -b gh-pages -n build/html -m 'Update by travis automatically'
    git push "https://${GH_TOKEN}@${GH_REF}" gh-pages:gh-pages --force
    # Deploy offline HTML and PDF files
    mkdir build/doc-dev && cd build
    mv html GMT_docs-dev && zip -r doc-dev/GMT_docs-dev.zip GMT_docs-dev
    cp latex/GMT_docs.pdf doc-dev/GMT_docs-dev.pdf
    ghp-import -b doc-dev -n doc-dev -m 'Update by travis automatically'
    git push "https://${GH_TOKEN}@${GH_REF}" doc-dev:doc-dev --force
else
    echo "Not in master branch"
fi
