# xfce Makefile

NM= xfce
VRS= 4.2.3.2
DIR= $(NM)-$(VRS)

FILE= $(DIR)-src.tar.bz2
URL-$(FILE)= http://www.xfce.org/archive/$(DIR)/fat_tarballs/$(FILE)
SHA-$(FILE)= d60827c2b0087e11575440ae53f18cb7d225ad7b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
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
	# FIXME: maybe copy to /etc/X11/xinit/xinitrc? The default there
	# calls xterm and twm, and none of these programs exist on the CD
	cp $(ROOT)/root/.xinitrc /root/
	cp ../desktop-files/* /usr/share/applications
	sed -i -e 's/mozilla/firefox/' /etc/xdg/xfce4/desktop/menu.xml*
	sed -i -e 's/Mozilla/Firefox/' /etc/xdg/xfce4/desktop/menu.xml*
	rm -f `grep -L 'include type="system"' /etc/xdg/xfce4/desktop/menu.xml*`
	for f in /etc/xdg/xfce4/panel/contents.xml* ; do ../cleanup-panel.pl $$f ; done
	sed -i -e '/Xft.dpi/d' /etc/xdg/xfce4/xinitrc
	mkdir -p /etc/xdg/xfce4/mcs_settings
	cp ../settings/* /etc/xdg/xfce4/mcs_settings

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
