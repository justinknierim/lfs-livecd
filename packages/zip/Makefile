# Zip Makefile

NM= zip
VRS= 2.31
DIR= $(NM)-$(VRS)

FILE= $(NM)231.tar.bz2
URL-$(FILE)= $(HTTPBLFS)/W-Z/$(FILE)
SHA-$(FILE)= 9e9a4718a03fa8d4cccd3802916268afeaf588bb

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -e 's@$$(INSTALL) man/zip.1@$$(INSTALL_PROGRAM) man/zip.1@' unix/Makefile
	make prefix=/usr -f unix/Makefile generic_gcc
	make prefix=/usr -f unix/Makefile install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
