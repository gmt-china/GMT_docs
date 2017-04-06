#!/bin/bash

git config user.name "Dongdong Tian"
git config user.email "seisman.info@gmail.com"

# Deploy Github Pages
ghp-import -b gh-pages -n build/html -m 'Update by travis automatically'
git push "https://${GH_TOKEN}@${GH_REF}" gh-pages:gh-pages --force
