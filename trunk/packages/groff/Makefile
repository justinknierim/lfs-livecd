# Groff Makefile

# ascii8 and nippon devices exist only for groff-1.18.1.1 as a patch
# rejected upstream.
# Do not upgrade this package before Debian does it!
# http://bugs.debian.org/196762

NM= groff
VRS= 1.18.1.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 19c8c83e6ee29dd6041dae0daf1c1d0debd3d32a

PATCH= $(DIR)-debian_fixes-1.patch
URL-$(PATCH)= $(HTTP)/$(NM)/$(PATCH)
SHA-$(PATCH)= 39fb82b9673523cb2451a0491929693226ea97dd

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH)} $(LFSSRC)

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
