OUTPUT_BASENAME := sichuan-cookbook-1972

build: pdf

all: pdf txt

pdf: $(OUTPUT_BASENAME).pdf

txt: $(OUTPUT_BASENAME).txt

page-list.txt: page-neat \
	$(addprefix page-neat/, $(addsuffix .jpg, $(basename $(notdir \
		$(wildcard tiff/a*.tif))))) \
	$(addprefix page-neat/, $(addsuffix .png, $(basename $(notdir \
		$(wildcard tiff/[bcpz]*.tif)))))
	ls -1 page-neat/* >$@

page-neat:
	mkdir -p $@

# The original book has the page size 185mm x 130mm. This length-to-width ratio
# is roughly equal to sqrt(2):1. Thus, with a 600dpi resolution, the image size
# of all the pages will be 4370px x 3091px.

page-neat/%.jpg: tiff/%.tif
	convert $^ \
		-quality 85 -depth 6 \
		$@

page-neat/b001.png: tiff/b001.tif
	# Chairman Mao quotes are printed in red color
	# Half inch width margin of the page will be filled with background color.
	convert $^ \
		\( +clone -crop 16x16+1280+256 +repage -scale 1x1! -scale 3901x300! \) \
			-geometry +0+0      -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 300x3770! \) \
			-geometry +0+300    -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 3091x300! \) \
			-geometry +0+4070   -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 300x3770! \) \
			-geometry +2791+300 -composite \
		-quality 100 -alpha off -depth 2 \
		$@

page-neat/%.png: tiff/%.tif
	convert $^ \
		\( +clone -crop 16x16+1280+256 +repage -scale 1x1! -scale 3901x300! \) \
			-geometry +0+0      -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 300x3770! \) \
			-geometry +0+300    -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 3091x300! \) \
			-geometry +0+4070   -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 300x3770! \) \
			-geometry +2791+300 -composite \
		-quality 100 -alpha off -grayscale Rec709Luma -depth 2 \
		$@

%.pdf: page-list.txt
	tesseract $^ $(basename $@) -l chi_sim pdf

%.txt: page-list.txt
	tesseract $^ $(basename $@) -l chi_sim txt

clean:
	$(RM) -r page-neat
	$(RM) *.pdf *.txt

.PHONY: all build clean pdf txt
