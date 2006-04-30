# man-db Makefile

NM= man-db
VRS= 2.4.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= a9f6ac22ccd97186005920cedb5f6611df13d4fa

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	mv man/de{_DE.88591,}
	mv man/es{_ES.88591,}
	mv man/it{_IT.88591,}
	mv man/ja{_JP.eucJP,}
	sed -i 's,\*_\*,??,'  man/Makefile.in
	sed -i '/\t\/usr\/man/d' src/man_db.conf.in
	echo '#define WEB_BROWSER "exec /usr/bin/lynx"' >>include/manconfig.h.in
	echo '#define COL "/usr/bin/col"' >>include/manconfig.h.in
	echo '#define VGRIND "/usr/bin/vgrind"' >>include/manconfig.h.in
	echo '#define GRAP "/usr/bin/grap"' >>include/manconfig.h.in
ifndef CROSS
	./configure --prefix=/usr --enable-mb-groff --disable-setuid
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr --enable-mb-groff --disable-setuid
endif
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
