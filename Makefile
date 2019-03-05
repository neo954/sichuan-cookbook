pdf: sichuan-cookbook-1972.pdf

txt: sichuan-cookbook-1972.txt

all: pdf txt

page-list.txt: page-neat \
	$(addprefix page-neat/, $(addsuffix .jpg, $(basename $(notdir \
		$(wildcard tiff/[az]*.tif))))) \
	$(addprefix page-neat/, $(addsuffix .png, $(basename $(notdir \
		$(wildcard tiff/[bcp]*.tif)))))
	ls -1 page-neat/* >$@

page-neat:
	mkdir -p $@

# Page size 4370px x 3090px, that is 185mm x 130mm in 600dpi.
page-neat/%.jpg: tiff/%.tif
	convert -quality 95 -depth 6 \
		$^ $@

page-neat/b001.png: tiff/b001.tif
	# Chairman Mao quotes are printed in red color
	convert -quality 100 -alpha off -depth 4 \
		-draw 'rectangle 0,0 3090,300' -fill '#ffffff' \
		-draw 'rectangle 0,4070 3090,4370 ' -fill '#ffffff' \
		-draw 'rectangle 0,0 300,4370' -fill '#ffffff' \
		-draw 'rectangle 2790,0 3090,4370' -fill '#ffffff' \
		$^ $@

page-neat/%.png: tiff/%.tif
	# Half inch white border is drawn
	convert -quality 100 -alpha off -grayscale Rec709Luma -depth 2 \
		-draw 'rectangle 0,0 3090,300' -fill '#ffffff' \
		-draw 'rectangle 0,4070 3090,4370 ' -fill '#ffffff' \
		-draw 'rectangle 0,0 300,4370' -fill '#ffffff' \
		-draw 'rectangle 2790,0 3090,4370' -fill '#ffffff' \
		$^ $@

sichuan-cookbook-1972.pdf: page-list.txt
	tesseract $^ $(basename $@) -l chi_sim pdf

sichuan-cookbook-1972.txt: page-list.txt
	tesseract $^ $(basename $@) -l chi_sim txt

clean:
	$(RM) $(TARGETS) page-neat page-list.txt

.PHONY: all clean pdf txt
