# libxcb Makefile

NM= libxcb
VRS= 1.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= b27c7eb86fd2ea43cea83cadcf20cc77abf5defe

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc \
	 --mandir=/usr/share/man --localstatedir=/var \
	 --docdir='$${datadir}'/doc/$(DIR)
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
