# man-db Makefile

NM= man-db
VRS= 2.5.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= b82b7ff0b13693cecbdc053b4d4381b2063017d1

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -e '\%\t/usr/man%d' -e '\%\t/usr/local/man%d' src/man_db.conf.in
	./configure --prefix=/usr --libexecdir=/usr/lib \
	 --sysconfdir=/etc --disable-setuid \
	 --enable-mb-groff --with-browser=/usr/bin/lynx \
	 --with-col=/usr/bin/col --with-vgrind=/usr/bin/vgrind \
	 --with-grap=/usr/bin/grap
	make
	make install
	install -m755 ../convert-mans /usr/bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
