# xfce Makefile

NM= xfce
VRS= 4.2.2
DIR= $(NM)-$(VRS)

FILE= $(DIR)-src.tar.bz2
URL-$(FILE)= $(HTTPBLFS)/W-Z/$(FILE)
SHA-$(FILE)= e589ded559cf86fbb92b85711081df0aca00249d

PATCH1= $(DIR)-message-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH1)
SHA-$(PATCH1)= 2d88093ce453fc549cbc33e86c9bf8151b0494e2

PATCH2= $(DIR)-textclip-1.patch
URL-$(PATCH2)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH2)
SHA-$(PATCH2)= ffd924c943d12f7d1e581edb2fc702bbeeab9743

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)

compile-stage2:
	cd src; for i in `cat ../../list`; \
	do unpack $$i.tar.gz ; \
	cd $$i ; \
	 if [ "$$i" = "xfce-mcs-plugins-4.2.2" ] ; then \
	 patch -Np1 -i ../../../$(PATCH1) ; fi ; \
	 if [ "$$i" = "libxfcegui4-4.2.2" ] ; then \
	 patch -Np1 -i ../../../$(PATCH2) ; fi ; \
	 ./configure --prefix=/usr --sysconfdir=/etc \
	 --enable-debug=no --enable-panel --enable-startup-notification \
	 --libexecdir=/usr/sbin ; \
	make $(PM) ; \
	make install ; cd .. ; done 

	cp $(ROOT)/root/.xinitrc /root/
	cp ../desktop-files/* /usr/share/applications
	sed -i -e 's/mozilla/firefox/' /etc/xdg/xfce4/desktop/menu.xml*
	sed -i -e 's/Mozilla/Firefox/' /etc/xdg/xfce4/desktop/menu.xml*
	rm -f `grep -L 'include type="system"' /etc/xdg/xfce4/desktop/menu.xml*`
	for f in /etc/xdg/xfce4/panel/contents.xml* ; do ../cleanup-panel.pl $$f ; done
	sed -i -e '/Xft.dpi/d' /etc/xdg/xfce4/xinitrc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
