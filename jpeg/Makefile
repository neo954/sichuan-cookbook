jpeg: $(addsuffix .jpeg, $(basename $(notdir $(wildcard ../tiff/*.tif))))

%.jpeg: ../tiff/%.tif
	convert $< \
		-quality 85 \
		$@

clean:
	$(RM) *.jpeg

.PHONY: jpeg clean
