# xorg-server Makefile

NM= xorg-server
VRS= 1.1.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://xorg.freedesktop.org/releases/individual/xserver/$(FILE)
SHA-$(FILE)= eb29dd4fea9f184321cbb5512f68b674ada4daf7

MESA_VRS= 6.5.1
DIR1= Mesa-$(MESA_VRS)

FILE1= MesaLib-$(MESA_VRS).tar.bz2
URL-$(FILE1)= http://heanet.dl.sourceforge.net/sourceforge/mesa3d/$(FILE1)
SHA-$(FILE1)= cd3b314808534b0306c7f89e9a72c9c23dbff239

PATCH1= xorg_server-1.1.1-dotclock-1.patch
PATCH2= xorg_server-1.1.1-newmesa-1.patch

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
	patch -Np1 -i ../$(PATCH2)
	autoreconf --force --install --verbose
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
	    --with-mesa-source=`pwd`/$(DIR1) --with-default-font-path=built-ins
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
