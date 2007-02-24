# Groff Makefile

# ascii8 and nippon devices exist only for groff-1.18.1.x as a patch
# rejected upstream.
# Do not upgrade this package before Debian does it!
# http://bugs.debian.org/196762

NM= groff
VRS= 1.18.1.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 70580701fd90cf6fe7fb70fe951cb2d66bd14e7c

PATCH= $(DIR)-debian_fixes-1.patch
URL-$(PATCH)= $(HTTP)/$(NM)/$(PATCH)
SHA-$(PATCH)= 4a171a1c7b6c493b5c4349aa18ff1905bddffcb0

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	sed -i -e 's/2010/002D/' -e 's/2212/002D/' \
	    -e 's/2018/0060/' -e 's/2019/0027/' font/devutf8/R.proto
	PAGE=$(pagesize) ./configure --prefix=/usr --enable-multibyte
	make
	make install
	ln -sf eqn /usr/bin/geqn
	ln -sf tbl /usr/bin/gtbl

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
