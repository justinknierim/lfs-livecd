# man-db Makefile

NM= man-db
VRS= 2.4.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://savannah.nongnu.org/download/man-db/$(FILE)
SHA-$(FILE)= 5c6ba8eb287a69f14433feb34e720b066536d163

PATCH1= $(DIR)-fixes-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/6.3/$(PATCH1)
SHA-$(PATCH1)= 5ac2a79c2e471991503173982728e65f60f3e071

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	mv man/de{_DE.88591,}
	mv man/es{_ES.88591,}
	mv man/it{_IT.88591,}
	mv man/ja{_JP.eucJP,}
	sed -i 's,\*_\*,??,'  man/Makefile.in
	sed -i -e '\%\t/usr/man%d' -e '\%\t/usr/local/man%d' src/man_db.conf.in
	echo '#define WEB_BROWSER "exec /usr/bin/lynx"' >>include/manconfig.h.in
	echo '#define COL "/usr/bin/col"' >>include/manconfig.h.in
	echo '#define VGRIND "/usr/bin/vgrind"' >>include/manconfig.h.in
	echo '#define GRAP "/usr/bin/grap"' >>include/manconfig.h.in
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --enable-mb-groff --disable-setuid
	make
	make install
	install -m755 ../convert-mans /usr/bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
