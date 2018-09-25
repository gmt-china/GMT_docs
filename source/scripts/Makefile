#
# Makefile for all figures in GMT_Docs
#
# PDF and PNG are generated at the same time
# Make sure PDFs always exist
#
OUT_DIR=../images
PDF = $(patsubst %.sh, $(OUT_DIR)/%.pdf, $(wildcard *.sh))

all: $(OUT_DIR) $(PDF) update clean

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

$(OUT_DIR)/%.pdf: %.sh
	sh $<

update:
	-mv *.png *.pdf ${OUT_DIR}/

clean:
	@rm -f *.png *.pdf
