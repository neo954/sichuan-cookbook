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
# 297mm x 210mm in 600 dpi => 7016px x 4961px
proof/p001.png: trim/a000.jpg trim/b001.png
	convert -density 600 -units PixelsPerInch \
		-size 7016x4961 xc:transparent \
		-fill none -stroke black -strokewidth 1 \
		-draw 'circle 283,1535 283,1677' \
		-draw 'line   283,1511 283,1559' \
		-draw 'line   259,1535 307,1535' \
		-draw 'line   283,1297 283,1321' \
		-draw 'line   283,1345 283,1369' \
		-draw 'line   283,1701 283,1725' \
		-draw 'line   283,1749 283,1773' \
		-draw 'circle 283,3425 283,3567' \
		-draw 'line   283,3401 283,3449' \
		-draw 'line   259,3425 307,3425' \
		-draw 'line   283,3187 283,3211' \
		-draw 'line   283,3235 283,3259' \
		-draw 'line   283,3591 283,3615' \
		-draw 'line   283,3639 283,3663' \
		png:- | \
	composite $< \
		-geometry +531+295 png:- \
		-quality 100 \
		png:- | \
	composite $(word 2, $^) \
		-geometry +3622+295 png:- \
		-quality 100 \
		png:- | \
	convert png:- \
		-quality 100 \
		$@

proof/p002.png: trim/b002.png trim/b021.png
	convert -density 600 -units PixelsPerInch \
		-size 7016x4961 xc:transparent \
		-fill none -stroke black -strokewidth 1 \
		-draw 'circle 6733,1535 6733,1677' \
		-draw 'line   6733,1511 6733,1559' \
		-draw 'line   6709,1535 6757,1535' \
		-draw 'line   6733,1297 6733,1321' \
		-draw 'line   6733,1345 6733,1369' \
		-draw 'line   6733,1701 6733,1725' \
		-draw 'line   6733,1749 6733,1773' \
		-draw 'circle 6733,3425 6733,3567' \
		-draw 'line   6733,3401 6733,3449' \
		-draw 'line   6709,3425 6757,3425' \
		-draw 'line   6733,3187 6733,3211' \
		-draw 'line   6733,3235 6733,3259' \
		-draw 'line   6733,3591 6733,3615' \
		-draw 'line   6733,3639 6733,3663' \
		png:- | \
	composite $< \
		-geometry +295+295 png:- \
		-quality 100 \
		png:- | \
	composite $(word 2, $^) \
		-geometry +3386+295 png:- \
		-quality 100 \
		png:- | \
	convert png:- \
		-quality 100 \
		$@

%.pdf: FILELIST.txt
	tesseract $< $(basename $@) -l chi_sim pdf

%.txt: FILELIST.txt
	tesseract $< $(basename $@) -l chi_sim txt

clean:
	$(RM) retinex/*.png trim/*.png
	$(RM) *.pdf *.txt

.PHONY: all build clean pdf txt
