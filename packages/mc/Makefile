# MC Makefile

NM= mc
VRS= 4.6.1
DIR= $(NM)-$(VRS)

FILE= $(NM)-$(VRS).tar.gz
URL-$(FILE)= http://www.ibiblio.org/pub/Linux/utils/file/managers/mc/$(FILE)
SHA-$(FILE)= 92be0802143245e0fb7e3847d70da614cad7d5fb

PATCH1= $(DIR)-bash32-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/blfs/svn/$(PATCH1)
SHA-$(PATCH1)= 7e516f2a5f1ce69884b8200da348c1d03c6dfe67

PATCH2= $(DIR)-debian_fixes-1.patch
URL-$(PATCH2)= http://www.linuxfromscratch.org/patches/blfs/svn/$(PATCH2)
SHA-$(PATCH2)= 29a81f756d14ea7028ca3cbbef1bf1df35ed0739

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	CPPFLAGS="-DUTF8" ./configure --prefix=/usr --enable-charset
	make
	convert-mans ISO-8859-1 UTF-8 lib/mc.hint{,.es,.it,.nl}
	convert-mans ISO-8859-2 UTF-8 lib/mc.hint{.cs,.hu,.pl}
	convert-mans ISO-8859-5 UTF-8 lib/mc.hint.sr
	convert-mans KOI8-R UTF-8 lib/mc.hint.ru
	convert-mans KOI8-U UTF-8 lib/mc.hint.uk
	convert-mans BIG5 UTF-8 lib/mc.hint.zh
	convert-mans ISO-8859-1 UTF-8 doc/{es,it}/mc.hlp.*
	convert-mans ISO-8859-2 UTF-8 doc/{hu,pl}/mc.hlp.*
	convert-mans ISO-8859-5 UTF-8 doc/sr/mc.hlp.sr
	convert-mans KOI8-R UTF-8 doc/ru/mc.hlp.ru
	make install
	chmod 1755 /usr/lib/mc/cons.saver

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
