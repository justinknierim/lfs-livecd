# mpfr Makefile

NM= mpfr
VRS= 2.3.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 37dbd478e1c136f37cf4c68eb1522e86e2307288

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --enable-thread-safe
	make
	-make -k check
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
