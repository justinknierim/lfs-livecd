# Xorg Makefile

# Package versions
NM= Xorg
VRS= 6.8.2
DIR= xc
FILE= X11R$(VRS)-src.tar.bz2
PATCH= $(NM)-6.8.1-luit_race-1.patch
URL= http://xorg.freedesktop.org/X11R$(VRS)/src-single/$(FILE)
URL1= http://www.linuxfromscratch.org/patches/downloads/xorg/$(PATCH)



#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(PATCH) ] ; then $(WGET) $(URL1) ; fi
	@if [ ! -d /usr/include/X11 ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH) && \
	 sed -i '/^SUBDIRS =/s/s etc$$//' programs/Xserver/Xprint/Imakefile && \
	 pushd config/util && \
	 make -f Makefile.ini lndir && \
	 cp lndir /usr/bin/ && \
	 popd && \
	 mkdir ../$(DIR)build && cd ../$(DIR)build && lndir ../$(DIR) && \
	 cp ../host.def config/cf/host.def && \
	 sed -i -e "s@#include <linux/config.h>@/* & */@" `grep -lr linux/config.h *` && \
	 ( make -j3 World 2>&1 | tee xorg-compile.log && exit $$PIPESTATUS ) && \
	 make install && make install.man && \
	 ln -sf ../X11R6/bin /usr/bin/X11 && \
	 ln -sf ../X11R6/lib/X11 /usr/lib/X11 && \
	 ln -sf ../X11R6/include/X11 /usr/include/X11 && \
	 /sbin/ldconfig ; fi
	@echo "/tmp/.ICE-unix dir 1777 root root" >> /etc/sysconfig/createfiles
	@cp $(ROOT)/etc/fonts/local.conf /etc/fonts/local.conf && \
	 fc-cache
	@make clean

clean:
	@-rm -rf $(DIR)
	@-rm -rf $(DIR)build
