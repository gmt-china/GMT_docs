# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SOURCEDIR     = source
BUILDDIR      = build
DOCNAME       = GMT_docs

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@echo "  xelatexpdf to make LaTeX files and run them through xelatex"
	@echo "  figures    to update all figures"
	@echo "  deploy     to deploy html, zip and PDF to github"
	@echo "  release    to prepare HTML and PDF files for release"

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

figures:
	@echo "Update all figures..."
	make -C scripts

xelatexpdf: Makefile latex
	@echo "Running LaTeX files through xelatex..."
	cd $(BUILDDIR)/latex; latexmk -xelatex -shell-escape -interaction=nonstopmode
	@echo "xelatex finished; the PDF files are in $(BUILDDIR)/latex."

pre-deploy: html xelatexpdf
	@echo "Deploy HTML, ZIP and PDF"
	cd $(BUILDDIR) && cp -r html $(DOCNAME) && zip -r html/$(DOCNAME).zip $(DOCNAME) && \
	cp latex/$(DOCNAME).pdf html && cd ..

deploy: pre-deploy
	ghp-import -b gh-pages -n $(BUILDDIR)/html -m "Update at `date +'%Y-%m-%d %H:%M:%S'`"
	git push origin gh-pages:gh-pages --force

release: html xelatexpdf
	cd $(BUILDDIR) && mv html $(DOCNAME) && zip -r ../$(DOCNAME).zip $(DOCNAME)/
	mv $(BUILDDIR)/latex/$(DOCNAME).pdf .
	rm -rf $(BUILDDIR)/*
