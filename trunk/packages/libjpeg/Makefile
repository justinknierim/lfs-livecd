# libjpeg Makefile

NM= libjpeg
VRS= 6b
DIR= jpeg-$(VRS)

FILE= jpegsrc.v$(VRS).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 9064e88e8c8bde13fb7ba809f3b84fa0737a981d

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:	
	./configure --prefix=/usr --enable-static --enable-shared
	make $(PM)
	make install
	/sbin/ldconfig

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
