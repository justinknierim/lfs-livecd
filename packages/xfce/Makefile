# xfce Makefile

NM= xfce
VRS= 4.2.3.2
DIR= $(NM)-$(VRS)

FILE= $(DIR)-src.tar.bz2
URL-$(FILE)= http://www.xfce.org/archive/$(DIR)/fat_tarballs/$(FILE)
SHA-$(FILE)= d60827c2b0087e11575440ae53f18cb7d225ad7b

BG= lfsrules-1600-1200.jpg
URL-$(BG)= http://www.linuxfromscratch.org/blfs/artwork/wallpapers/$(BG)
SHA-$(BG)= 8f4abcc49ccc37874a1d2bf958ee7db024e21a3a

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(BG)
	$(std_build)

compile-stage2:
	cd src; for i in `cat ../../list`; \
	do unpack $$i.tar.gz ; \
	cd $$i ; \
	 ./configure --prefix=/usr --sysconfdir=/etc \
	 --enable-debug=no --enable-panel --enable-startup-notification \
	 --libexecdir=/usr/sbin --enable-compositor ; \
	make $(PM) ; \
	make install ; cd .. ; done
	cp $(ROOT)/root/.xinitrc /etc/X11/xinit/xinitrc
	cp ../desktop-files/* /usr/share/applications
	rm -f `grep -L 'include type="system"' /etc/xdg/xfce4/desktop/menu.xml*`
	for f in /etc/xdg/xfce4/panel/contents.xml* ; do ../cleanup-panel.pl $$f ; done
	sed -i -e '/Xft.dpi/d' /etc/xdg/xfce4/xinitrc
	mkdir -p /etc/xdg/xfce4/mcs_settings
	cp ../settings/* /etc/xdg/xfce4/mcs_settings
	cp ../$(BG) /usr/share/xfce4/backdrops/

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
