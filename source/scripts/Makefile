#
# Makefile for all figures in GMT_Docs
#
OUT_DIR=../images
PNG = $(patsubst %.sh, $(OUT_DIR)/%.png, $(wildcard *.sh))
PDF = $(patsubst %.sh, $(OUT_DIR)/%.pdf, $(wildcard *.sh))

all: $(OUT_DIR) $(PNG) $(PDF) update clean

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

$(OUT_DIR)/%.png: %.sh
	sh $<

$(OUT_DIR)/%.pdf: %.sh
	sh $<

update:
	-mv *.png *.pdf ${OUT_DIR}/

clean:
	@rm -f *.png *.pdf
