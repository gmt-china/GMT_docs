# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line
SPHINXBUILD   = sphinx-build
SPHINXOPTS    = -j auto -n
SOURCEDIR     = source
BUILDDIR      = build
DOCNAME       = GMT_docs
HTML          = dirhtml

# Put it first so that "make" without argument is like "make help"
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile build build_html build_pdf optimize_pdf serve

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option. $(O) is meant as a shortcut for $(SPHINXOPTS)
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

build: build_html build_html_zip build_pdf

build_html: $(HTML)

build_html_zip: html
	cp -r $(BUILDDIR)/html $(BUILDDIR)/$(DOCNAME)
	cd $(BUILDDIR)
	zip -r $(DOCNAME).zip $(DOCNAME)
	rm -r $(DOCNAME)

build_pdf: latex
	tectonic $(BUILDDIR)/latex/$(DOCNAME).tex
	mv $(BUILDDIR)/latex/$(DOCNAME).pdf $(BUILDDIR)/$(DOCNAME).pdf

# reduce file size of the final PDF documentation
optimize_pdf: build_pdf
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress \
		-dNOPAUSE -dQUIET -dBATCH \
		-sOutputFile=$(BUILDDIR)/$(DOCNAME).optimized.pdf \
		$(BUILDDIR)/$(DOCNAME).pdf
	mv $(BUILDDIR)/$(DOCNAME).optimized.pdf $(BUILDDIR)/$(DOCNAME).pdf

serve: $(HTML)
	cd $(BUILDDIR)/$(HTML) && python -m http.server
