# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SOURCEDIR     = source
BUILDDIR      = build
DOCNAME       = GMT_docs
HTML          = dirhtml

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@echo "  figures    to update all figures"

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

figures:
	@echo "Update all figures..."
	make -C $(SOURCEDIR)/scripts

build: $(HTML) latexpdf
	@echo "Deploy HTML and PDF"
	cd $(BUILDDIR) && \
	cp latex/$(DOCNAME).pdf $(HTML) && \
	cd ..

# Watch a Sphinx directory and rebuild the documentation when a change is detected.
# See https://github.com/GaretJax/sphinx-autobuild for details
watch:
	sphinx-autobuild --open-browser --delay 1 -b dirhtml $(SOURCEDIR) $(BUILDDIR)/dirhtml

serve: $(HTML)
	cd $(BUILDDIR)/$(HTML) && python -m http.server
