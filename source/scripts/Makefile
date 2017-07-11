#
# Makefile for all figures in GMT_Docs
#
OUT_DIR=../images
PNG = $(patsubst %.sh, $(OUT_DIR)/%.png, $(wildcard *.sh))
PDF = $(patsubst %.sh, $(OUT_DIR)/%.pdf, $(wildcard *.sh))

all: $(OUT_DIR) $(PNG) $(PDF) clean

%.ps: %.sh
	sh $<

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

$(OUT_DIR)/%.png: %.ps
	gmt psconvert -A -Tg -P -D$(OUT_DIR) $<

$(OUT_DIR)/%.pdf: %.ps
	gmt psconvert -A -Tf -P -D$(OUT_DIR) $<

clean:
	@rm -f *.ps
