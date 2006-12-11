# MC Makefile

NM= mc
VRS= 4.6.1
DIR= $(NM)-$(VRS)

FILE= $(NM)-$(VRS).tar.gz
URL-$(FILE)= http://www.ibiblio.org/pub/Linux/utils/file/managers/mc/$(FILE)
SHA-$(FILE)= 92be0802143245e0fb7e3847d70da614cad7d5fb

PATCH1= $(NM)_$(VRS)-6.diff.gz
URL-$(PATCH1)= http://ftp.debian.org/debian/pool/main/m/mc/$(PATCH1)
SHA-$(PATCH1)= 5f25f69801d192ff806818c79121865abf8392f1

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	zcat ../$(PATCH1) | patch -Np1
	rm debian/patches/01_mc.ext.in.mime.patch
	rm debian/patches/02_debian_syntax.patch
	rm debian/patches/08_awk.patch
	rm debian/patches/36_developer_mode.patch
	for a in debian/patches/*.patch ; do \
	    if egrep -q '+++.*mc-4' $$a ; then \
		patch -Np1 -i $$a ; \
	    else \
		patch -Np0 -i $$a ; \
	    fi ; \
	done
	CPPFLAGS="-DUTF8" ./configure --with-screen=slang --prefix=/usr \
	    --enable-charset
	iconv -f ISO-8859-1 -t UTF-8 lib/mc.hint > tmp && mv tmp lib/mc.hint
	iconv -f ISO-8859-1 -t UTF-8 doc/xnc.hlp > tmp && mv tmp doc/xnc.hlp
	iconv -f ISO-8859-1 -t UTF-8 lib/mc.hint.es > tmp && mv tmp lib/mc.hint.es
	iconv -f ISO-8859-1 -t UTF-8 doc/es/xnc.hlp > tmp && mv tmp doc/es/xnc.hlp
	iconv -f ISO-8859-1 -t UTF-8 lib/mc.hint.it > tmp && mv tmp lib/mc.hint.it
	iconv -f ISO-8859-1 -t UTF-8 doc/it/xnc.hlp > tmp && mv tmp doc/it/xnc.hlp
	iconv -f ISO-8859-1 -t UTF-8 lib/mc.hint.nl > tmp && mv tmp lib/mc.hint.nl
	iconv -f ISO-8859-2 -t UTF-8 lib/mc.hint.cs > tmp && mv tmp lib/mc.hint.cs
	iconv -f ISO-8859-2 -t UTF-8 lib/mc.hint.hu > tmp && mv tmp lib/mc.hint.hu
	iconv -f ISO-8859-2 -t UTF-8 doc/hu/xnc.hlp > tmp && mv tmp doc/hu/xnc.hlp
	iconv -f ISO-8859-2 -t UTF-8 lib/mc.hint.pl > tmp && mv tmp lib/mc.hint.pl
	iconv -f ISO-8859-2 -t UTF-8 doc/pl/xnc.hlp > tmp && mv tmp doc/pl/xnc.hlp
	iconv -f ISO-8859-5 -t UTF-8 lib/mc.hint.sr > tmp && mv tmp lib/mc.hint.sr
	iconv -f ISO-8859-5 -t UTF-8 doc/sr/xnc.hlp > tmp && mv tmp doc/sr/xnc.hlp
	iconv -f ISO-8859-5 -t UTF-8 lib/mc.menu.sr > tmp && mv tmp lib/mc.menu.sr
	iconv -f koi8-r -t UTF-8 lib/mc.hint.ru > tmp && mv tmp lib/mc.hint.ru
	iconv -f koi8-r -t UTF-8 doc/ru/xnc.hlp > tmp && mv tmp doc/ru/xnc.hlp
	iconv -f koi8-u -t UTF-8 lib/mc.hint.uk > tmp && mv tmp lib/mc.hint.uk
	iconv -f big5 -t UTF-8 lib/mc.hint.zh > tmp && mv tmp lib/mc.hint.zh
	make
	make install

clean:
	-rm -rf $(NM)

.PHONY: clean chroot compile-stage2
