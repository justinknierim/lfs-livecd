# Module-Init-Tools Makefile

NM= module-init-tools
VRS= 3.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= f233cab26208aa7d21a8ca24e4a9712af23a5a1d

FILE1= $(NM)-testsuite-$(VRS).tar.bz2
URL-$(FILE1)= $(HTTP)/$(NM)/$(FILE)
SHA=$(FILE1)= bc01e741ba7c125e8266a270523721c349b62a84

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(FILE1)} $(LFSSRC)

compile-stage2:
	touch modprobe.conf.5
ifndef CROSS
	./configure --prefix="" --enable-zlib
else
	CC="gcc $(64FLAGS)" ./configure --prefix="" --enable-zlib
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
