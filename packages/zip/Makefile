# Zip Makefile

NM= zip
VRS= 2.31
DIR= $(NM)-$(VRS)

FILE= $(NM)231.tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= bd1046289138f11f21a2f748b2814d83a78875d1

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -e 's@$$(INSTALL) man/zip.1@$$(INSTALL_PROGRAM) man/zip.1@' unix/Makefile
	make prefix=/usr MANDIR=/usr/share/man/man1 -f unix/Makefile generic_gcc
	make prefix=/usr MANDIR=/usr/share/man/man1 -f unix/Makefile install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
