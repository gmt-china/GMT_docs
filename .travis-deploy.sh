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
name=Dongdong Tian
mail=seisman.info@gmail.com
docdir=doc-dev
docname=GMT_docs-dev
pdfname=GMT_docs.pdf

if [ ${TRAVIS_BRANCH} = "master" -a ${TRAVIS_PULL_REQUEST} = 'false' ]; then
    echo "In master branch, deploying now..."
    git config user.name "${name}"
    git config user.email "${mail}"

    # Deploy Github Pages
    ghp-import -b gh-pages -n build/html -m 'Update by travis automatically'
    git push "https://${GH_TOKEN}@${GH_REF}" gh-pages:gh-pages --force

    # Deploy offline HTML and PDF files
    mkdir build/${docdir} && cd build
    mv html ${docname} && zip -r ${docdir}/${docname}.zip ${docname}

    cp latex/${pdfname} ${docdir}/${docname}.pdf
    ghp-import -b ${docdir} ${docdir} -m 'Update by travis automatically'
    git push "https://${GH_TOKEN}@${GH_REF}" ${docdir}:${docdir} --force
else
    echo "Not in master branch"
fi
