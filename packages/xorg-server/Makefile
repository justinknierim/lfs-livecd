# xorg-server Makefile

NM= xorg-server
VRS= 1.2.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://xorg.freedesktop.org/releases/individual/xserver/$(FILE)
SHA-$(FILE)= 85fa0e8fa7d6bea6f1a73c66a57488ea68dffa17

MESA_VRS= 6.5.2
DIR1= Mesa-$(MESA_VRS)

FILE1= MesaLib-$(MESA_VRS).tar.bz2
URL-$(FILE1)= http://heanet.dl.sourceforge.net/sourceforge/mesa3d/$(FILE1)
SHA-$(FILE1)= ba860bb6ee57c02202342dfd5927464a068ea18f

PATCH1= xorg_server-$(VRS)-dotclock-1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)

compile-stage2:
	unpack ../$(FILE1)
	sed -i -e '/DPI/s,75,92,' hw/xfree86/common/xf86Priv.h hw/dmx/dmxinit.c
	sed -i -e 's,#ifdef KDRIVESERVER,#if 1,' dix/dixfonts.c
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --datadir=/usr/share --sysconfdir=/etc --localstatedir=/var \
	    --with-mesa-source=`pwd`/$(DIR1) --with-default-font-path=built-ins \
	    --with-xkb-path=/usr/share/X11/xkb --with-xkb-output=/var/lib/xkb
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
