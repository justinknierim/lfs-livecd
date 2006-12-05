# libjpeg Makefile

NM= libjpeg
VRS= 6b
DIR= jpeg-$(VRS)

FILE= jpegsrc.v$(VRS).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/jpeg/$(FILE)
SHA-$(FILE)= 0b4ef1e7dcee85e631a958b1ea493b6b0f2f2250

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
