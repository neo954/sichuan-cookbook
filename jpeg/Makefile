download: $(shell awk '{ print $$1 }' FILELIST)

update: $(shell shasum -a 512 -c SHA512SUMS 2>/dev/null | \
	awk -F ':' '!/ OK$$/ { print $$1 }')

%.jpg: FILELIST
	curl -L $$(awk '/^$@ / { print $$NF }' $<) -o $@

check: SHA512SUMS
	shasum -a 512 -c $<

clean:
	$(RM) *.jpg

.PHONY: check clean download update
