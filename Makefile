# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         =
BUILDDIR      = build

# User-friendly check for sphinx-build
ifeq ($(shell which $(SPHINXBUILD) >/dev/null 2>&1; echo $$?), 1)
$(error The '$(SPHINXBUILD)' command was not found. Make sure you have Sphinx installed, then set the SPHINXBUILD environment variable to point to the full path of the '$(SPHINXBUILD)' executable. Alternatively you can add the directory with the executable to your PATH. If you don't have Sphinx installed, grab it from http://sphinx-doc.org/)
endif

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source

.PHONY: help clean linkcheck figures github
.PHONY: html latex xelatexpdf

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html       to make standalone HTML files"
	@echo "  xelatexpdf to make LaTeX files and run them through xelatex"
	@echo "  linkcheck  to check all external links for integrity"
	@echo "  figures    to update all figures"
	@echo "  latex      to make LaTeX files"
	@echo "  dummy      to check syntax errors of document sources"
	@echo "  deploy     to deploy html, zip and PDF to github"

clean:
	rm -rf $(BUILDDIR)/*

figures:
	@echo "Update all figures..."
	make -C scripts

linkcheck:
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/linkcheck/output.txt."

deploy: html xelatexpdf
	@echo "Deploy HTML, ZIP and PDF"
	ghp-import -b gh-pages -n build/html -m "Update at `date +'%Y-%m-%d %H:%M:%S'`"
	git push origin gh-pages:gh-pages --force

	mkdir -p build/doc-dev && cd build && \
	cp -r html GMT_docs-dev && zip -r doc-dev/GMT_docs-dev.zip GMT_docs-dev && \
	cp latex/GMT_docs.pdf doc-dev/GMT_docs.pdf  && \
	ghp-import -b doc-dev doc-dev -m 'Update by travis automatically' && \
	git push origin doc-dev:doc-dev --force


## Builers
html: figures
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

latex: figures
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo
	@echo "Build finished; the LaTeX files are in $(BUILDDIR)/latex."
	@echo "Run \`make' in that directory to run these through (pdf)latex" \
	      "(use \`make latexpdf' here to do that automatically)."

xelatexpdf: figures
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo "Running LaTeX files through xelatex..."
	cd $(BUILDDIR)/latex; latexmk -xelatex -shell-escape -interaction=nonstopmode
	@echo "xelatex finished; the PDF files are in $(BUILDDIR)/latex."

dummy:
	$(SPHINXBUILD) -b dummy $(ALLSPHINXOPTS) $(BUILDDIR)/dummy
	@echo
	@echo "Build finished. Dummy builder generates no files."


release: html xelatexpdf
	cd $(BUILDDIR) && mv html GMT_docs && zip -r ../GMT_docs.zip GMT_docs/
	mv $(BUILDDIR)/latex/GMT_docs.pdf .
	rm -rf $(BUILDDIR)/*
