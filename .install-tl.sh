#!/bin/bash

REMOTE="http://ctan.sharelatex.com/tex-archive/systems/texlive/tlnet"

mkdir -p /tmp/install-texlive
cd /tmp/install-texlive/

curl -sSL $REMOTE/install-tl-unx.tar.gz | tar -xz -C ./ --strip-components=1

cat << EOF > texlive.profile
selected_scheme scheme-basic
TEXMFHOME ~/.texmf
collection-basic 1
collection-fontsrecommended 1
collection-langchinese 1
collection-latex 1
collection-latexrecommended 1
collection-xetex 1
option_doc 0
option_src 0
EOF

PLATFORM=`./install-tl --print-platform`
TEXLIVE=$(./install-tl --version | egrep -o "20..")
TEXBIN="/usr/local/texlive/${TEXLIVE}/bin/${PLATFORM}"
./install-tl -q -profile texlive.profile -repository $REMOTE

echo PATH=$PATH:$TEXBIN
echo 'export PATH=$PATH':$TEXBIN >> ~/.bash_profile
$TEXBIN/tlmgr install tabulary latexmk ulem environ trimspaces titlesec \
                      varwidth framed threeparttable wrapfig upquote capt-of \
                      multirow eqparbox needspace
