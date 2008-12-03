# PCRE Makefile

NM= pcre
VRS= 7.8
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 552909f9d18e1954eec639f926957a4cb2de1ec3

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --docdir=/usr/share/doc/$(DIR) \
	 --enable-utf8 --enable-unicode-properties \
	 --enable-pcregrep-libz --enable-pcregrep-libbz2
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
