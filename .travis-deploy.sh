#!/bin/bash

docdir=doc-dev
docname=GMT_docs-dev
pdfname=GMT_docs.pdf

git config user.name "Dongdong Tian"
git config user.email "seisman.info@gmail.com"

# Deploy Github Pages
ghp-import -b gh-pages -n build/html -m 'Update by travis automatically'
git push "https://${GH_TOKEN}@${GH_REF}" gh-pages:gh-pages --force

# Deploy offline HTML and PDF files
mkdir build/${docdir} && cd build
mv html ${docname} && zip -r ${docdir}/${docname}.zip ${docname}
cp latex/${pdfname} ${docdir}/${docname}.pdf
ghp-import -b ${docdir} ${docdir} -m 'Update by travis automatically'
git push "https://${GH_TOKEN}@${GH_REF}" ${docdir}:${docdir} --force --quiet
