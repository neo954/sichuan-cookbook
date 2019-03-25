OUTPUT_BASENAME := sichuan-cookbook-1972

build: pdf

all: pdf txt

pdf: $(OUTPUT_BASENAME).pdf

txt: $(OUTPUT_BASENAME).txt

page-list.txt: \
	$(addprefix trim/, $(addsuffix .jpg, $(basename $(notdir \
		$(wildcard jpeg/a*.jpg))))) \
	$(addprefix trim/, $(addsuffix .png, $(basename $(notdir \
		$(wildcard jpeg/[bcpz]*.jpg)))))
	ls -1 trim/* >$@

# The original book has the page size 185mm x 130mm. This length-to-width ratio
# is roughly equal to sqrt(2):1. Thus, with a 600dpi resolution, the image size
# of all the pages will be 4370px x 3091px.

trim/%.jpg: retinex/%.png
	convert $< \
		-auto-level \
		-quality 85 -depth 6 \
		$@

trim/b001.png: retinex/b001.png
# Chairman Mao quotes are printed in red color
	convert $< \
		\( +clone -crop 16x16+1280+256 +repage -scale 1x1! \
			-scale 3091x450! \) \
			-geometry +0+0      -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +0+450    -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 3091x150! \) \
			-geometry +0+4220   -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +2716+450 -composite \
		-quality 100 -alpha off -depth 2 \
		$@

trim/%.png: retinex/%.png
# Margins will be filled with background color of the page.
# 3/4 inch width margin on top. With 600dpi, it is 450px.
# 5/8 inch width margin on left and right. With 600 dpi, it is 375px.
# 1/4 inch width margin on bottom. With 600dpi, it is 150px.
	convert $< \
		\( +clone -crop 16x16+1280+256 +repage -scale 1x1! \
			-scale 3091x450! \) \
			-geometry +0+0      -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +0+450    -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 3091x150! \) \
			-geometry +0+4220   -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +2716+450 -composite \
		-level 12%,88%,0.618 \
		-quality 100 -alpha off -grayscale Rec709Luma -depth 2 \
		$@

retinex/%.png: jpeg/%.jpg
# Retinex-based intensity correction and thresholding
# https://www.hpl.hp.com/techreports/2002/HPL-2002-82.html
	convert $< \
		-filter Gaussian -resize 309x437 \
		-define filter:sigma=5 -resize 3091x4370 \
		-quality 100 -alpha off -depth 8 \
		png:- | \
	composite $< -compose Divide_Dst png:- \
		-quality 100 -alpha off -depth 8 \
		png:- | \
	convert png:- \
		-auto-level \
		-quality 100 -alpha off -depth 8 \
		$@

%.pdf: page-list.txt
	tesseract $< $(basename $@) -l chi_sim pdf

%.txt: page-list.txt
	tesseract $< $(basename $@) -l chi_sim txt

clean:
	$(RM) retinex/*.png trim/*.png
	$(RM) *.pdf *.txt

.PHONY: all build clean pdf txt
