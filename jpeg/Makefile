jpeg: $(shell awk -F '|' '{ print $$1 }' FILELIST)

%.jpg: FILELIST
	curl $$(awk -F '|' '/^$@\|/ { print $$NF }' $<) -o $@

check: SHA512SUMS
	shasum -a 512 -c $<

clean:
	$(RM) *.jpg

.PHONY: jpeg check clean
