# Sysvinit Makefile

NM= sysvinit
VRS= 2.86
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e4b8c4ab3b080dd8cc3f29f0c38a32fc7307d8ef

PATCH1= $(DIR)-reexec06-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= d06fd7274e767c1c98be27d1dc4adb135260e479

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	sed -i 's@Sending processes@& started by init@g' src/init.c
ifndef CROSS
	ROOT="" make $(PM) -C src
else
	ROOT="" make -C src clobber
	ROOT="" make -C src CC="gcc $(64FLAGS)"
endif
	ROOT="" make -C src install
	cp $(ROOT)/etc/inittab /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
