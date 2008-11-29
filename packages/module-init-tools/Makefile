# Module-Init-Tools Makefile

NM= module-init-tools
VRS= 3.4.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= cb957cccbbeb4d4c0bbd3f2be4d9848bcfb61102

PATCH1= $(DIR)-manpages-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 3b3a0a6a56d0f50168f1a3447a0afc103a63d828

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/ --enable-zlib --mandir=/usr/share/man
	make
	make INSTALL=install install
	install -m644 $(ROOT)/etc/modprobe.conf /etc/modprobe.conf

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
