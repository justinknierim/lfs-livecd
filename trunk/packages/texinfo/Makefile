# Texinfo Makefile

NM= texinfo
VRS= 4.8
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= b19e906f7220294c1e8b087d583c50f5c4d7c420

PATCH1= $(DIR)-tempfile_fix-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= ac721310cbe17f1661173598954d20484be6c767

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

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/$(PATCH1) $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
ifndef CROSS
	./configure --prefix=/usr
else
	CC="gcc ${BUILD64}" ./configure --prefix=/usr
endif
	make $(PM)
	make install
	make TEXMF=/usr/share/texmf install-tex

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
