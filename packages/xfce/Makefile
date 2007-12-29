# xfce Makefile

NM= xfce
VRS= 4.4.1
DIR= $(NM)-$(VRS)

FILE= $(DIR)-src.tar.bz2
URL-$(FILE)= http://www.xfce.org/archive/$(DIR)/fat_tarballs/$(FILE)
SHA-$(FILE)= 8b809291dc081557c2513b38c640246be5e8d2ca

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
	do unpack $$i*.tar.bz2 ; \
	cd $$i* ; \
	 sed -i '/xfce4-tips/d' Makefile.in ; \
	 ./configure --prefix=/usr --sysconfdir=/etc \
	 --enable-debug=no --enable-panel --enable-startup-notification \
	 --libexecdir=/usr/sbin --enable-compositor --disable-python \
	 --enable-session-screenshots --with-sound=alsa ; \
	make ; \
	make install ; cd .. ; rm -rf $$i*/ ; done
	sed -i 's/aumix -v\\([+-]\\?\\)\\([^"]*\\)/amixer set PCM \\2%\\1/' \
	    /usr/share/xfce-mcs-plugins/shortcuts/default.xml
	cp $(ROOT)/root/.xinitrc /etc/X11/xinit/xinitrc
	cp ../desktop-files/* /usr/share/applications
	install -D -m644 ../helpers.rc /etc/xdg/xfce4/helpers.rc
	install -D -m644 ../terminalrc /etc/xdg/Terminal/terminalrc
	sed -i -e '/Xft.dpi/d' /etc/xdg/xfce4/xinitrc
	sed -i 's/mice/simple/' /etc/xdg/xfce4-session/xfce4-session.rc
	mkdir -p /etc/xdg/xfce4/mcs_settings
	cp ../settings/* /etc/xdg/xfce4/mcs_settings
	cp ../$(BG) /usr/share/xfce4/backdrops/

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
