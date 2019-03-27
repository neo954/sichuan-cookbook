OUTPUT_BASENAME := sichuan-cookbook

build: pdf

all: pdf

pdf: $(OUTPUT_BASENAME).pdf

sichuan-cookbook.dvi: sichuan-cookbook.tex cookbook.cls \
	chairman-mao-quotes.tex foreword.tex \
	$(wildcard recipe-*.tex)
	latex $< $(word 2, $^)
	latex $< $(word 2, $^)

%.dvi: %.tex
	latex $^

%.ps: %.dvi
	dvips -D 600 -j -Ppdf -o $@ $^

%.eps: %.ps
	ps2eps $^

%.eps: %.png
	convert $^ $@

%.pdf: %.ps
	ps2pdf -r600 $^ $@

%.png: %.pdf
	pdftoppm -r 600 -gray -png $^ >$@

%.eps: %.vcf
	qrencode -o $@ -t EPS -l L -m 0 <$^

%.png: %.vcf
	qrencode -o $@ -l L -s 1 -m 0 <$^

%.gif: %.png
	convert $^ $@

%.jpg: %.png
	convert -quality 99 $^ $@

%.txt: %.pdf
	pdftotext -layout $^ $@

clean:
	$(RM) *.aux *.dvi *.eps *.gif *.idx *.ilg *.ind *.jpg *.log *.out \
		*.pdf *.png *.ps *.txt *.toc

.PHONY: all build clean pdf
