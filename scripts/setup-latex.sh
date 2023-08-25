#!/usr/bin/env bash
#
# Install LaTeX packages that are needed for building the PDF documentation
#

# Update tlmgr itself
tlmgr update --self
# Install packages needed by the PDF documentation
tlmgr install \
	capt-of caption colortbl ctex enumitem everysel fancyhdr fandol \
	float ms needspace oberdiek parskip pdftexcmds tabulary \
    titlesec ulem upquote varwidth wrapfig xcolor xecjk \
	xindy zhnumber
# Install packages for GMT LaTeX integration
tlmgr install collection-fontsrecommended
