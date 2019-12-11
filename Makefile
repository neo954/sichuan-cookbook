# $Id$
#
# BSD 3-Clause License
#
# Copyright (C) 2019 GONG Jie <gongjie.jie@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

OUTPUT_BASENAME := sichuan-cookbook-1972

build: scan

all: scan

scan: $(OUTPUT_BASENAME)-scan.pdf

proof: $(OUTPUT_BASENAME)-proof-a4.pdf

FILELIST: \
	$(addprefix trim/, $(addsuffix .jpg, $(basename $(notdir \
		$(wildcard jpeg/a*.jpg))))) \
	$(addprefix trim/, $(addsuffix .png, $(basename $(notdir \
		$(wildcard jpeg/[bcpz]*.jpg)))))
	mkdir -p trim
	ls -1 trim/* >$@

# The original book has the page size 185mm x 130mm. This length-to-width ratio
# is roughly equal to sqrt(2):1. Thus, with a 600dpi resolution, the image size
# of all the pages will be 4370px x 3091px.

trim/a000.jpg: trim/%.jpg: jpeg/%.jpg
	convert $< \
		-filter Gaussian -resize 309x437 \
		-define filter:sigma=25 -resize 3090x4370! \
		-quality 100 -alpha off \
		png:- | \
	composite $< -compose Divide_Dst png:- \
		-quality 100 -alpha off \
		png:- | \
	convert png:- \
		-auto-level \
		-quality 100 -alpha off \
		png:- | \
	convert png:- \
		-auto-level \
		-quality 85 \
		$@

# Chairman Mao quotes are printed in red color
trim/b001.png: trim/%.png: jpeg/%.jpg
	convert $< \
		-filter Gaussian -resize 309x437 \
		-define filter:sigma=8 -resize 3091x4370! \
		-quality 100 -alpha off \
		png:- | \
	composite $< -compose Divide_Dst png:- \
		-quality 100 -alpha off \
		png:- | \
	convert png:- \
		\( +clone -crop 16x16+1280+256 +repage -scale 1x1! \
			-scale 3091x450! \) \
			-geometry +0+0      -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +0+450    -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 3091x150! \) \
			-geometry +0+4220   -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +2716+450 -composite \
		-auto-level \
		-level 50%,84%,0.618 \
		-quality 100 -alpha off \
		png:- | \
	convert png:- \
		-filter Gaussian -resize 3091x4370 \
		-fuzz 2% +level-colors '#e60012,white' \
		-quality 100 -alpha off +dither -colors 16 \
		$@

trim/z999.png: trim/%.png: jpeg/%.jpg
	convert $< \
		-filter Gaussian -resize 309x437 \
		-define filter:sigma=8 -resize 3091x4370! \
		-quality 100 -alpha off \
		png:- | \
	composite $< -compose Divide_Dst png:- \
		-quality 100 -alpha off \
		png:- | \
	convert png:- \
		\( +clone -crop 16x16+1280+256 +repage -scale 1x1! \
			-scale 2896x3856! \) \
			-geometry +0+0      -composite \
		\( +clone -crop 16x16+2944+256 +repage -scale 1x1! \
			-scale  195x4370! \) \
			-geometry +2896+0   -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 1984x272! \) \
			-geometry +0+3856   -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 2896x242! \) \
			-geometry +0+4128   -composite \
		-auto-level \
		-level 50%,84%,0.618 \
		-quality 100 -alpha off -grayscale Rec709Luma \
		png:- | \
	convert png:- \
		-filter Gaussian -resize 3091x4370 \
		-fill '#ffffcc' -draw 'rectangle 2896,0 3091,4370' \
		-quality 100 -alpha off +dither -colors 16 \
		$@

trim/b002.png trim/b022.png trim/b042.png trim/c008.png trim/p266.png trim/p300.png: trim/%.png: jpeg/%.jpg
	convert $< \
		-fill white -draw 'rectangle 0,0 3091,4370' \
		-quality 100 -alpha off -grayscale Rec709Luma -depth 1 \
		$@

# Retinex-based intensity correction and thresholding
# https://www.hpl.hp.com/techreports/2002/HPL-2002-82.html

# Margins will be filled with background color of the page.
# 3/4 inch width margin on top. With 600dpi, it is 450px.
# 5/8 inch width margin on left and right. With 600 dpi, it is 375px.
# 1/4 inch width margin on bottom. With 600dpi, it is 150px.
trim/%.png: jpeg/%.jpg
	convert $< \
		-filter Gaussian -resize 309x437 \
		-define filter:sigma=8 -resize 3091x4370! \
		-quality 100 -alpha off \
		png:- | \
	composite $< -compose Divide_Dst png:- \
		-quality 100 -alpha off \
		png:- | \
	convert png:- \
		\( +clone -crop 16x16+1280+256 +repage -scale 1x1! \
			-scale 3091x450! \) \
			-geometry +0+0      -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +0+450    -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 3091x150! \) \
			-geometry +0+4220   -composite \
		\( +clone -crop 1x1+0+0 +repage -scale 375x3770! \) \
			-geometry +2716+450 -composite \
		-auto-level \
		-level 50%,84%,0.618 \
		-quality 100 -alpha off -grayscale Rec709Luma \
		png:- | \
	convert png:- \
		-filter Gaussian -resize 3091x4370 \
		-quality 100 -alpha off -grayscale Rec709Luma -depth 2 \
		$@

# A4 size galley proof
# 296.7mm x 209.9mm in 600 dpi => 7008px x 4958px

# With ISO 838 filing holes marked.
proof/%-r.png: deps
	convert -density 600 -units PixelsPerInch \
		-size 7008x4958 xc:white \
		-fill none -stroke black -strokewidth 1 \
		-draw 'circle 282,1534 282,1605' \
		-draw 'line   282,1510 282,1558' \
		-draw 'line   258,1534 306,1534' \
		-draw 'line   282,1357 282,1381' \
		-draw 'line   282,1405 282,1429' \
		-draw 'line   282,1639 282,1663' \
		-draw 'line   282,1687 282,1711' \
		-draw 'circle 282,3424 282,3495' \
		-draw 'line   282,3400 282,3448' \
		-draw 'line   258,3424 306,3424' \
		-draw 'line   282,3247 282,3271' \
		-draw 'line   282,3295 282,3319' \
		-draw 'line   282,3529 282,3553' \
		-draw 'line   282,3577 282,3601' \
		png:- | \
	composite $(wildcard trim/$(firstword $(subst -, , \
			$(basename $(notdir $@)))).*) \
		-geometry +532+294 png:- \
		-quality 100 \
		png:- | \
	composite $(wildcard trim/$(word 2, $(subst -, , \
			$(basename $(notdir $@)))).*) \
		-geometry +3623+294 png:- \
		-quality 100 \
		png:- | \
	convert png:- \
		-quality 100 -alpha off \
		$@

proof/%-l.png: deps
	convert -density 600 -units PixelsPerInch \
		-size 7008x4958 xc:white \
		-fill none -stroke black -strokewidth 1 \
		-draw 'circle 6726,1534 6726,1605' \
		-draw 'line   6726,1510 6726,1558' \
		-draw 'line   6702,1534 6750,1534' \
		-draw 'line   6726,1357 6726,1381' \
		-draw 'line   6726,1405 6726,1429' \
		-draw 'line   6726,1639 6726,1663' \
		-draw 'line   6726,1687 6726,1711' \
		-draw 'circle 6726,3424 6726,3495' \
		-draw 'line   6726,3400 6726,3448' \
		-draw 'line   6702,3424 6750,3424' \
		-draw 'line   6726,3247 6726,3271' \
		-draw 'line   6726,3295 6726,3319' \
		-draw 'line   6726,3529 6726,3553' \
		-draw 'line   6726,3577 6726,3601' \
		png:- | \
	composite $(wildcard trim/$(firstword $(subst -, , \
			$(basename $(notdir $@)))).*) \
		-geometry +294+294 png:- \
		-quality 100 \
		png:- | \
	composite $(wildcard trim/$(word 2, $(subst -, , \
			$(basename $(notdir $@)))).*) \
		-geometry +3385+294 png:- \
		-quality 100 \
		png:- | \
	convert png:- \
		-quality 100 -alpha off \
		$@

$(OUTPUT_BASENAME)-scan.pdf: FILELIST
	tesseract $< $(basename $@) -l chi_sim pdf

$(OUTPUT_BASENAME)-scan.txt: FILELIST
	tesseract $< $(basename $@) -l chi_sim txt

clean:
	$(RM) trim/*.png
	$(RM) proof/*.png
	$(RM) *.pdf *.txt

$(OUTPUT_BASENAME)-proof-a4.pdf: deps $(shell \
	while read -r LINE ; \
	do \
		echo "$${LINE%:*}" ; \
	done <deps)
	convert -density 600 -units PixelsPerInch \
		$(wildcard proof/*.png) \
		$@

deps: FILELIST
	mkdir -p proof
	while read -r FILE_ONE && read -r FILE_TWO ; \
	do \
		if [ "$${SIDE}" != "r" ] ; \
		then \
			SIDE="r" ; \
		else \
			SIDE="l" ; \
		fi ; \
		PAGE_ONE="$${FILE_ONE%.*}" ; \
		PAGE_ONE="$${PAGE_ONE#*/}" ; \
		PAGE_TWO="$${FILE_TWO%.*}" ; \
		PAGE_TWO="$${PAGE_TWO#*/}" ; \
		echo "proof/$${PAGE_ONE}-$${PAGE_TWO}-$${SIDE}.png: $${FILE_ONE} $${FILE_TWO}" ; \
	done <$< >$@

include deps
.PHONY: all build clean pdf txt
