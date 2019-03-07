OUTPUT_BASENAME := sichuan-cookbook-1972

build: pdf

all: pdf txt

pdf: $(OUTPUT_BASENAME).pdf

txt: $(OUTPUT_BASENAME).txt

page-list.txt: \
	$(addprefix page-neat/, $(addsuffix .jpg, $(basename $(notdir \
		$(wildcard tiff/a*.tif))))) \
	$(addprefix page-neat/, $(addsuffix .png, $(basename $(notdir \
		$(wildcard tiff/[bcpz]*.tif)))))
	ls -1 page-neat/* >$@

# The original book has the page size 185mm x 130mm. This length-to-width ratio
# is roughly equal to sqrt(2):1. Thus, with a 600dpi resolution, the image size
# of all the pages will be 4370px x 3091px.

page-neat/%.jpg: lightness/%.png page-neat
	convert $< \
		-auto-level \
		-quality 85 -depth 6 \
		$@

page-neat/b001.png: lightness/b001.png page-neat
# Chairman Mao quotes are printed in red color
	convert $< \
		\( +clone -crop 16x16+1280+256 +repage -scale 1x1! -scale 3091x450! \) \
			-geometry +0+0      -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +0+450    -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 3091x150! \) \
			-geometry +0+4220   -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +2716+450 -composite \
		-auto-level \
		-quality 100 -alpha off -depth 2 \
		$@

page-neat/%.png: lightness/%.png page-neat
# Margins will be filled with background color of the page.
# 3/4 inch width margin on top. With 600dpi, it is 450px.
# 5/8 inch width margin on left and right. With 600 dpi, it is 375px.
# 1/4 inch width margin on bottom. With 600dpi, it is 150px.
	convert $< \
		\( +clone -crop 16x16+1280+256 +repage -scale 1x1! -scale 3091x450! \) \
			-geometry +0+0      -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +0+450    -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 3091x150! \) \
			-geometry +0+4220   -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +2716+450 -composite \
		-auto-level \
		-quality 100 -alpha off -grayscale Rec709Luma -depth 2 \
		$@

page-neat:
	mkdir -p $@

lightness/%.png: tiff/%.tif blur/%.png lightness
	composite $< -compose Divide_Dst $(word 2, $^) \
		-quality 100 -alpha off -depth 8 \
		$@

lightness:
	mkdir -p $@

blur/%.png: tiff/%.tif blur
	convert $< \
		-blur 0x50 \
		-quality 100 -alpha off -depth 8 \
		$@

blur:
	mkdir -p $@

%.pdf: page-list.txt
	tesseract $< $(basename $@) -l chi_sim pdf

%.txt: page-list.txt
	tesseract $< $(basename $@) -l chi_sim txt

clean:
	$(RM) -r page-neat
	$(RM) *.pdf *.txt

.PHONY: all build clean pdf txt
