#!/bin/bash
set -e

cd build/html
git init
git config user.name "Dongdong Tian"
git config user.email "seisman.info@gmail.com"

git add .
git commit -m 'Deploy to GitHub Pages automatically by Travis'

git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1
