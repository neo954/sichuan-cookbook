jpeg: $(addsuffix .jpg, $(basename $(notdir $(wildcard ../tiff/*.tif))))

%.jpg: ../tiff/%.tif
	convert $< \
		-quality 85 \
		$@

clean:
	$(RM) *.jpg

.PHONY: jpeg clean
