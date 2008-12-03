# cvs Makefile

NM= cvs
VRS= 1.11.23
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= a51c531eebaff2dfdcc0fb6d94c8c6e509e06d7d

PATCH= $(DIR)-zlib-1.patch
URL-$(PATCH)= $(HTTPBLFS)/$(NM)/$(PATCH)
SHA-$(PATCH)= 0d20bab8a6b6e419a8c900d082b487ad6a3aec38

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	./configure --prefix=/usr --with-rsh=ssh
	make
	make install
	install -m755 -d /usr/share/doc/$(DIR)
	install -v -m644 FAQ README /usr/share/doc/$(DIR)
	install -m644 doc/*.pdf /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
