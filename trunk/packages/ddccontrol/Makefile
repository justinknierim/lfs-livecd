# DDCControl Makefile

NM= ddccontrol
VRS= 0.4.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/$(NM)/$(FILE)
SHA-$(FILE)= f224711bd7da96c3ed7fd75528aa794e2e7dc01d

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
ifeq ($(LFS-ARCH),ppc)
	sed -i -e '/sis.Po/d' -e 's|sis[^ ]*||' src/ddcpci/Makefile.in
	sed -i '/sis/d' src/ddcpci/main.c
	sed -i 's|sys/io.h|asm/io.h|' src/ddcpci/intel810.c
endif
	./configure --prefix=/usr --disable-gnome-applet
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
