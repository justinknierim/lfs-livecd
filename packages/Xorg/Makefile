# Xorg Makefile

NM= Xorg
VRS= 6.8.2
DIR= xc

FILE= X11R$(VRS)-src.tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 632e25a202bc41bb9b1c5dbc8bbb0d775c6593b0

PATCH1= xorg-$(VRS)-luit_race-2.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 3a8434bc51cc21e1d72c24d157a05e679ad6ef6c

PATCH2= X11R6.8.2-src-gcc4-1.patch
URL-$(PATCH2)= $(HTTPBLFS)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 1b6fc0f487fa9e4546d364e850959c7e599f6b2b

PATCH3= xorg-$(VRS)-locale_names-1.patch
URL-$(PATCH3)= $(HTTPBLFS)/$(NM)/$(PATCH3)
SHA-$(PATCH3)= 32d4664d0d32955accfdf7079567180785836292

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2) $(PATCH3)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH3)
	sed -i '/^SUBDIRS =/s/s etc$$//' programs/Xserver/Xprint/Imakefile
	pushd config/util ; \
	make -f Makefile.ini lndir ; \
	cp lndir /usr/bin/ ; \
	popd
	mkdir ../$(DIR)build
	cd ../$(DIR)build ; \
	lndir -silent ../$(DIR) ; \
	cp ../host.def config/cf/host.def ; \
	sed -i -e "s@#include <linux/config.h>@/* & */@" `grep -lr linux/config.h *`
	cd ../$(DIR)build ; make $(PM) World
	cd ../$(DIR)build ; make install ; \
	 make install.man
	ln -sf ../X11R6/bin /usr/bin/X11
	ln -sf ../X11R6/lib/X11 /usr/lib/X11
	ln -sf ../X11R6/include/X11 /usr/include/X11
	/sbin/ldconfig
	echo -e "#!/bin/sh\nexec /usr/X11R6/bin/X -nolisten tcp" >/etc/X11/xinit/xserverrc
	chmod 755 /etc/X11/xinit/xserverrc
	install -m644 $(ROOT)/etc/X11/xorg.conf /etc/X11/xorg.conf
	install -m644 $(ROOT)/etc/X11/app-defaults/XTerm /etc/X11/app-defaults/XTerm
	cp $(ROOT)/etc/fonts/local.conf /etc/fonts/local.conf
	fc-cache

clean:
	-rm -rf $(DIR)
	-rm -rf $(DIR)build

.PHONY: clean chroot compile-stage2
