TARGETS = sichuan-cookbook-1972.pdf sichuan-cookbook-1972.txt

all: $(TARGETS)

page-list.txt: tiff/*.tif
	ls -1 tiff/*.tif >$@

sichuan-cookbook-1972.pdf: page-list.txt
	tesseract $^ $(basename $@) -l chi_sim pdf

sichuan-cookbook-1972.txt: page-list.txt
	tesseract $^ $(basename $@) -l chi_sim txt

clean:
	$(RM) $(TARGETS) page-list.txt
.PHONY: all clean
