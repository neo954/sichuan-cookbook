<!--
BSD 3-Clause License

Copyright (c) 2024 Quux System and Technology. All rights reserved.

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

# Sichuan Cookbook (四川菜谱) Digital Remake

:warning: This project,
[Sichuan Cookbook](https://github.com/neo954/sichuan-cookbook), is focused on
**authentic culinary instructions**, not a **software or technical guide**.
Please note that on platforms like GitHub, the terminology **cookbook** is
often associated with software-related guide, which is not the case here.

----

*Sichuan Cookbook* (四川菜谱) is a renowned classic, first published in July
1972 by Chengdu Catering Company (成都市饮食公司). It contains 312 traditional
recipes, many of which are no longer served in modern restaurants. The aim of
this project is to digitize the *Sichuan Cookbook* correctly, preserving its
rich culinary history.

* [x] Photograph each page of the book using a digital camera.
* [x] Enhance the photos, correcting exposure and perspective distortion, and
      adjust the typographical area.
* [x] Convert the enhanced photos into binary images.
* [x] Perform Optical Character Recognition (OCR) on the binary images.
* [x] Generate a PDF of the original book from the binary images and the OCR
      results.
* [x] Abstract each recipe into a data structure and document them in LaTeX.
* [x] Replicate the original book's appearance using LaTeX typesetting.
* [x] Compile the LaTeX documents to create a final PDF version.
* [x] Optionally, annotate the book with additional research findings.

![Sichuan Cookbook 1972 Remake](https://user-images.githubusercontent.com/12424088/219829436-a9b9cbe1-0f75-4a0c-8683-4948953561e4.png)

According to the Copyright Law of China, concerning a work of a legal person
or other organization, the term of protection for the copyrights to that work
shall be 50 years and shall end on December 31 of the 50th year after the
work's first publication. Consequently, the first edition of the *Sichuan
Cookbook* (四川菜谱) entered the public domain after December 31, 2022. This
project was made publicly available on January 1, 2023.

## Download a Digitized Copy of the Book

### Sichuan Cookbook 1972 Remake

For a modern eBook format, download the *[Sichuan Cookbook 1972
Remake](https://github.com/neo954/sichuan-cookbook/releases/download/v1.0.6.1/sichuan-cookbook.v1.0.6.1.pdf)*
<sub>(3.54 MB)</sub> in A5 paper size (210mm × 148mm), a remade edition of the
original paperback.

### Scanned Copy

You can download a draft of the *[Sichuan Cookbook
1972](https://github.com/neo954/sichuan-cookbook/releases/download/v0.0.4-pre-alpha/sichuan-cookbook-1972-scan.pdf)*
<sub>(138 MB)</sub>, which is a scanned copy in 185mm × 130mm paper size with
an unproofed OCR text layer, for reference.

## Developing Environment Setup

### Operating System Selection

Preferred operating systems are Debian or Ubuntu, though other Linux
distributions are compatible. Apple macOS is also suitable if necessary
command-line tools are installed.

## Digitizing the Book

### Remastered Digital Version

* Each book page was photographed with a digital camera and processed with
  Adobe Lightroom Classic for RAW decoding, perspective distortion correction,
  and other minor adjustments.
* To avoid bloating the git repository, all JPEG photos are hosted on
  ``user-images.githubusercontent.com``. Download all JPEG photos
  <sub>(625 MiB)</sub> using the following command:
  ```
  make -C jpeg
  ```
* Alternatively, download all JPEG files in a single tarball from
  [here](https://github.com/neo954/sichuan-cookbook/releases/download/v0.0.3-pre-alpha/sichuan-cookbook-1972.jpeg.tar)
  <sub>(625 MB)</sub>.

#### Prerequisites for Image Processing

* The original book's dimensions (185mm × 130mm) are maintained, corresponding
  to an aspect ratio of approximately √2:1.
* For 600dpi resolution, the digital image size should be 4370px x 3091px.
* All JPEG photos are processed with ImageMagick and performed OCR with
  Tesseract Open Source OCR Engine.
  ```
  sudo apt-get install imagemagick tesseract-ocr tesseract-ocr-chi-sim
  ```

#### Compilation Instructions

* Compile the processed images into a PDF using the following commands:
  ```
  make -C jpeg
  make scan
  ```

### LaTeX Remake of the Book

#### Prerequisites for LaTeX Remake

* The book is recreated using XeLaTeX with support for multiple fonts:
  ```
  sudo apt-get install -y fonts-cns11643-kai fonts-hanazono fonts-noto texlive-full
  ```

#### Compiling

* Compile the LaTeX remake into a PDF with the following command:
  ```
  make -C latex
  ```

# Contributing to the Project

## Proofreading

* We invite contributions for proofreading each recipe under the latex
  directory.
* Volunteers can claim unassigned tasks listed in the [GitHub
  issues](https://github.com/neo954/sichuan-cookbook/issues?q=is%3Aissue+is%3Aopen+Proofread+sort%3Acreated-asc+no%3Aassignee).
* Utilize the [A4 paper size scanned copy for
  printing](https://github.com/neo954/sichuan-cookbook/releases/download/v0.0.4-pre-alpha/sichuan-cookbook-1972-proof-a4.pdf)
<sub>(145 MB)</sub> as a reference for proofreading.
* Report any typographical errors by commenting on the issue page where you
  claimed the task. Pull requests for corrections are highly encouraged.

[modeline1]: # ( vim: set filetype=markdown noautoindent nojoinspaces: )
[modeline2]: # ( vim: set fileencoding=utf-8 spell spelllang=en: )
[modeline3]: # ( vim: set textwidth=78 tabstop=4 shiftwidth=4 softtabstop=4: )
