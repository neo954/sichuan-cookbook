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

build: pdf

all: pdf txt

pdf: $(OUTPUT_BASENAME).pdf

txt: $(OUTPUT_BASENAME).txt

FILELIST.txt: \
	$(addprefix trim/, $(addsuffix .jpg, $(basename $(notdir \
		$(wildcard jpeg/a*.jpg))))) \
	$(addprefix trim/, $(addsuffix .png, $(basename $(notdir \
		$(wildcard jpeg/[bcpz]*.jpg)))))
	ls -1 trim/* >$@

# The original book has the page size 185mm x 130mm. This length-to-width ratio
# is roughly equal to sqrt(2):1. Thus, with a 600dpi resolution, the image size
# of all the pages will be 4370px x 3091px.

trim/%.jpg: jpeg/%.jpg
	convert $< \
		-filter Gaussian -resize 309x437 \
		-define filter:sigma=25 -resize 3090x4370 \
		-background white -extent 3091x4370-0-0 \
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
		-filter Gaussian -resize 2060x2913 \
		-quality 85 \
		$@

# Chairman Mao quotes are printed in red color
trim/b001.png: jpeg/b001.jpg
	convert $< \
		-filter Gaussian -resize 309x437 \
		-define filter:sigma=8 -resize 3090x4370 \
		-background white -extent 3091x4370-0-0 \
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
		-filter Gaussian -resize 2060x2913 \
		-fuzz 2% +level-colors '#e60012,white' \
		-quality 100 -alpha off +dither -colors 4 \
		$@

trim/z999.png: jpeg/z999.jpg
	convert $< \
		-filter Gaussian -resize 309x437 \
		-define filter:sigma=8 -resize 3090x4370 \
		-background white -extent 3091x4370-0-0 \
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
		-quality 100 -alpha off \
		png:- | \
	convert png:- \
		-filter Gaussian -resize 2060x2913 \
		-quality 100 -alpha off +dither -colors 4 \
		$@

trim/b002.png trim/b022.png trim/b042.png trim/c008.png trim/p266.png trim/p300.png: trim/%.png: jpeg/%.jpg
	convert $< \
		-fill white -draw 'rectangle 0,0 3091,4370' \
		png:- | \
	convert png:- \
		-filter Gaussian -resize 2060x2913 \
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
		-define filter:sigma=8 -resize 3090x4370 \
		-background white -extent 3091x4370-0-0 \
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
		-filter Gaussian -resize 2060x2913 \
		-quality 100 -alpha off -grayscale Rec709Luma -depth 2 \
		$@

%.pdf: FILELIST.txt
	tesseract $< $(basename $@) -l chi_sim pdf

%.txt: FILELIST.txt
	tesseract $< $(basename $@) -l chi_sim txt

clean:
	$(RM) retinex/*.png trim/*.png
	$(RM) *.pdf *.txt

.PHONY: all build clean pdf txt
