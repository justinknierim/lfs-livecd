# Texinfo Makefile

NM= texinfo
VRS= 4.8
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= b19e906f7220294c1e8b087d583c50f5c4d7c420

PATCH1= $(DIR)-tempfile_fix-2.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH1)
SHA-$(PATCH1)= c995a67be7a57bd984ec708f4ff71dbe74cbae36

PATCH50= $(DIR)-multibyte-1.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH50)
SHA-$(PATCH50)= cb7f2c85a6f0ed73e8c4d1772e20b886a8c0de96

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	./configure --prefix=$(WD)
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH50)
	$(std_build)
	cp $(SRC)/{$(PATCH1),$(PATCH50)} $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH50)
ifndef CROSS
	./configure --prefix=/usr
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr
endif
	make $(PM)
	make install
	make TEXMF=/usr/share/texmf install-tex

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
