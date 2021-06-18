# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXBUILD   = sphinx-build
SPHINXOPTS    = -j auto -n
SOURCEDIR     = source
BUILDDIR      = build
DOCNAME       = GMT_docs
HTML          = dirhtml

# disable "gmt end show" and one-liner auto display for GMT 6 modern mode
export GMT_END_SHOW=off

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile build build_html build_pdf optimize_pdf serve watch

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

build: build_html build_pdf

build_html: $(HTML)

build_pdf: latexpdf optimize_pdf
	cp $(BUILDDIR)/latex/$(DOCNAME).pdf $(BUILDDIR)/$(HTML)/

# reduce file size of the final PDF documentation
optimize_pdf: latexpdf
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress \
		-dNOPAUSE -dQUIET -dBATCH \
		-sOutputFile=$(BUILDDIR)/latex/$(DOCNAME).optimized.pdf \
		$(BUILDDIR)/latex/$(DOCNAME).pdf
	mv $(BUILDDIR)/latex/$(DOCNAME).optimized.pdf $(BUILDDIR)/latex/$(DOCNAME).pdf

serve: $(HTML)
	cd $(BUILDDIR)/$(HTML) && python -m http.server

# Watch a Sphinx directory and rebuild the documentation when a change is detected.
# See https://github.com/GaretJax/sphinx-autobuild for details
watch:
	sphinx-autobuild --open-browser --delay 1 -b ${HTML} ${SPHINXOPTS} $(SOURCEDIR) $(BUILDDIR)/${HTML}
