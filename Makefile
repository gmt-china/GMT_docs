# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line
SPHINXBUILD   = sphinx-build
SPHINXOPTS    = -j auto -n -w sphinx_warnings.txt
SOURCEDIR     = source
BUILDDIR      = build
DOCNAME       = GMT_docs
HTML          = dirhtml
PAGEFIND      = pagefind

# Put it first so that "make" without argument is like "make help"
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile build build_html build_pdf optimize_pdf server pagefind dirhtml

dirhtml:
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@echo "Running Pagefind for Chinese search support..."
	$(PAGEFIND) --site "$(BUILDDIR)/$(HTML)" --output-subdir "pagefind"

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option. $(O) is meant as a shortcut for $(SPHINXOPTS)
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

htmlzip: html
	cp -r $(BUILDDIR)/html $(BUILDDIR)/$(DOCNAME)
	cd $(BUILDDIR); zip -r $(DOCNAME).zip $(DOCNAME); rm -r $(DOCNAME); cd ..

pdf: latex
	tectonic $(BUILDDIR)/latex/$(DOCNAME).tex
	mv $(BUILDDIR)/latex/$(DOCNAME).pdf $(BUILDDIR)/$(DOCNAME).pdf

# reduce file size of the final PDF documentation
optimize_pdf: pdf
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress \
		-dNOPAUSE -dQUIET -dBATCH \
		-sOutputFile=$(BUILDDIR)/$(DOCNAME).optimized.pdf \
		$(BUILDDIR)/$(DOCNAME).pdf
	mv $(BUILDDIR)/$(DOCNAME).optimized.pdf $(BUILDDIR)/$(DOCNAME).pdf

server: $(HTML)
	cd $(BUILDDIR)/$(HTML) && python -m http.server
