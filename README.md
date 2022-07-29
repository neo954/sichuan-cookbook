*Sichuan Cookbook 1972* (四川菜谱) is a legendary classic book. It was
compiled by Chengdu Catering Company of Sichuan (四川省成都市饮食公司)
and released in Jul 1972. In this book, many traditional recipes are described
in detail. Many recipes have been lost now.

The goal of this project is to digitize *Sichuan Cookbook 1972* properly.

* [x] Take photos of each page of the book with a digital camera.
* [x] Process the photos, correct exposure, and perspective distortion, and
      adjust the type area.
* [x] Create binary images from the processed photos.
* [x] Run OCR (optical character recognition) on the binary images.
* [x] Create a PDF book of the original book from the binary images and the
      OCR results.
* [ ] Organize each recipe in the book with an abstract data structure, and
      save them as a LaTeX document.
* [ ] Reproduce the appearance of the original book with LaTeX typesetting.
* [ ] Render LaTeX documents and create a PDF book.
* [ ] Optionally, add comments to the book based on research.

According to the Copyright Law of China, concerning a work of a legal
person or other organization, the term of protection for the copyrights to
that work shall be 50 years and shall end on Dec 31 of the 50th year after the
work's first publication. Thus, after Dec 31, 2022, Sichuan Cookbook 1972 will
enter the public domain. Therefore, this project is planned to be released to
the public on Jan 1, 2023.

## Download the scan copy of the book

A draft copy of *[Sichuan Cookbook
1972](https://github.com/neo954/sichuan-cookbook/releases/download/v0.0.3-alpha/sichuan-cookbook-1972.pdf)*
<sub>(75.6 MB)</sub> can be downloaded. This is an A5 paper size scanned copy
with an unproofread OCR text underlayer.

## Set up a developing environment

### The selection of operating system

Debian or Ubuntu is preferred. But other Linux distros can be used. I do not
see any obstruction here. Apple macOS can also be used, if all the command
line tools needed are properly installed.

## Build a PDF of the book

### The scan copy of the book

Each page of the book is captured by a digital camera, and then processed with
Adobe Lightroom Classic for RAW decoding, perspective distortion correction,
and some other minor adjustments. To keep large JPEG photos out of
the git repository, all the JPEG photos are stored in
``user-images.githubusercontent.com``. Download all the JPEG photos with the
following command.  All these JPEG photos are around 626 MiB.
```
make -C jpeg
```

#### Prerequisite

The original book has a page size of 185 mm $\times$ 130 mm. This
length-to-width ratio is roughly equal to $\sqrt{2} : 1$. Thus, with a 600 dpi
resolution, the image size of all the pages will be 4370 px $\times$ 3091 px.

All the JPEG photos will be processed with ImageMagick, and then OCRed
with Tesseract Open Source OCR Engine.
```
sudo apt-get install imagemagick tesseract-ocr tesseract-ocr-chi-sim
```

Build the PDF with the following commands.
```
make -C jpeg
make scan
```

### The latex copy of the book

#### Prerequisite

The book is recreated with XeTeX.
```
sudo apt-get install texlive-latex-recommended texlive-xetex texlive-lang-cjk \
    fonts-noto-cjk fonts-noto-cjk-extra
```

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

[modeline1]: # ( vim: set filetype=markdown noautoindent: )
[modeline2]: # ( vim: set fileencoding=utf-8 spell spelllang=en: )
[modeline3]: # ( vim: set textwidth=78 tabstop=4 shiftwidth=4 softtabstop=4: )
