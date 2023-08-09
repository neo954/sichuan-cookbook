<!--
BSD 3-Clause License

Copyright (c) 2023 Quux System and Technology. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->

*Sichuan Cookbook* (四川菜谱) is a legendary classic book. It was compiled by
Chengdu Catering Company (成都市饮食公司) and released in Jul 1972. In this
book, many traditional recipes are described in detail. Many recipes have been
lost now.

The goal of this project is to digitize *Sichuan Cookbook* properly.

* [x] Take photos of each page of the book with a digital camera.
* [x] Process the photos, correct exposure, and perspective distortion, and
      adjust the type area.
* [x] Create binary images from the processed photos.
* [x] Run OCR (optical character recognition) on the binary images.
* [x] Create a PDF book of the original book from the binary images and the
      OCR results.
* [x] Organize each recipe in the book with an abstract data structure, and
      save them as a $\mathrm{L\kern-.36em\lower-.428571ex\hbox{\small{A}}\kern-.15emT\kern-.1667em\lower.5ex\hbox{E}\kern-.125emX}$ document.
* [x] Reproduce the appearance of the original book with $\mathrm{L\kern-.36em\lower-.428571ex\hbox{\small{A}}\kern-.15emT\kern-.1667em\lower.5ex\hbox{E}\kern-.125emX}$ typesetting.
* [x] Render $\mathrm{L\kern-.36em\lower-.428571ex\hbox{\small{A}}\kern-.15emT\kern-.1667em\lower.5ex\hbox{E}\kern-.125emX}$ documents and create a PDF book.
* [x] Optionally, add comments to the book based on research.

![Sichuan Cookbook 1972 Remake](https://user-images.githubusercontent.com/12424088/219829436-a9b9cbe1-0f75-4a0c-8683-4948953561e4.png)

According to the Copyright Law of China, concerning a work of a legal person
or other organization, the term of protection for the copyrights to that work
shall be 50 years and shall end on Dec 31 of the 50th year after the work's
first publication. Thus, after Dec 31, 2022, the first edition of the
paperback book, *Sichuan Cookbook* (四川菜谱), entered the public domain.
Therefore, this project has been released to the public on Jan 1, 2023.

## Download a digitized copy of the book

### Sichuan Cookbook 1972 Remake

For a contemporary eBook, download *[Sichuan Cookbook 1972
Remake](https://github.com/neo954/sichuan-cookbook/releases/download/v1.0.2/sichuan-cookbook.v1.0.2.pdf)*
<sub>(3.46 MB)</sub>. This is an A5 paper size (210mm $\times$ 148mm) remake
edition of the original paperback book.

### Scanned copy

A draft copy of *[Sichuan Cookbook
1972](https://github.com/neo954/sichuan-cookbook/releases/download/v0.0.3-pre-alpha/sichuan-cookbook-1972.pdf)*
<sub>(75.6 MB)</sub> can be downloaded. This is a 185mm $\times$ 130mm paper
size scanned copy with an unproofread OCR text underlayer.

## Set up a developing environment

### The selection of operating system

Debian or Ubuntu is preferred. But other Linux distros can be used. I do not
see any obstruction here. Apple macOS can also be used, if all the command
line tools needed are properly installed.

## Build a digitized copy of the book

### The digitized remaster of the book

Each page of the book was captured by a digital camera, and then processed with
Adobe Lightroom Classic for RAW decoding, perspective distortion correction,
and some other minor adjustments. To keep large JPEG photos out of
the git repository, all the JPEG photos are stored in
``user-images.githubusercontent.com``. Download all the JPEG photos with the
following command. Please notice the size of all these JPEG photos is around
625 MiB.
```
make -C jpeg
```

Or, all the JPEG files can be downloaded in [one
tarball](https://github.com/neo954/sichuan-cookbook/releases/download/v0.0.3-pre-alpha/sichuan-cookbook-1972.jpeg.tar)
<sub>(625 MB)</sub>.

#### Prerequisite

The original book has a page size of 185mm $\times$ 130mm. This
length-to-width ratio is roughly equal to $\sqrt{2} : 1$. Thus, with a 600dpi
resolution, the image size of all the pages will be 4370px $\times$ 3091px.

All the JPEG photos will be processed with ImageMagick, and then OCRed
with Tesseract Open Source OCR Engine.
```
sudo apt-get install imagemagick tesseract-ocr tesseract-ocr-chi-sim
```

#### Compiling

Build the PDF with the following commands.
```
make -C jpeg
make scan
```

### The LaTeX remake of the book

#### Prerequisite

The book is recreated with $\mathrm{X\kern-.1em\lower.5ex\hbox{Ǝ}\kern-.15emL\kern-.36em\lower-.428571ex\hbox{\small{A}}\kern-.15emT\kern-.1667em\lower.5ex\hbox{E}\kern-.125emX}$.
```
sudo apt-get install -y fonts-cns11643-kai fonts-hanazono fonts-noto texlive-full
```

#### The font - Patch-Kai

A couple of Chinese character glyphs in Unicode CJK Extension E, Extension G
do not exist in either Fandol-Kai or TW-Kai. An OpenType font, Patch-Kai is
created to fill in the gap. Only a handful of glyphs are in it.

Copy the font file to the local font directory.
```
cp fonts/Patch-Kai.otf ~/.fonts
```

#### Compiling

Build the PDF with the following command.
```
make -C latex
```
# Contributing

## Proofreading

For each receipt under the `latex` directory, proofreading is wanted. If you
want to help to proofread, please claim the unassigned working items from
[GitHub
issues](https://github.com/neo954/sichuan-cookbook/issues?q=is%3Aissue+is%3Aopen+Proofread+sort%3Acreated-asc+no%3Aassignee).

This [A4 paper size scanned copy for
printing](https://github.com/neo954/sichuan-cookbook/releases/download/v0.0.3-alpha/sichuan-cookbook-1972-proof-a4.pdf)
<sub>(80.6 MB)</sub> is preferred to be utilized as a reference for
proofreading.

Please report typos of a receipt with a new comment on the same issue page you
claimed. Of course, pull requests are always welcome!

[modeline1]: # ( vim: set filetype=markdown noautoindent nojoinspaces: )
[modeline2]: # ( vim: set fileencoding=utf-8 spell spelllang=en: )
[modeline3]: # ( vim: set textwidth=78 tabstop=4 shiftwidth=4 softtabstop=4: )
