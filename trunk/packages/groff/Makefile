# Groff Makefile

# ascii8 and nippon devices exist only for groff-1.18.1.1 as a patch
# rejected upstream.
# Do not upgrade this package before Debian does it!
# http://bugs.debian.org/196762

NM= groff
VRS= 1.18.1.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/$(NM)/$(FILE)
SHA-$(FILE)= 19c8c83e6ee29dd6041dae0daf1c1d0debd3d32a

PATCH= groff_1.18.1.1-8.diff.gz
URL-$(PATCH)= http://ftp.debian.org/debian/pool/main/g/$(NM)/$(PATCH)
SHA-$(PATCH)= 6423b528127de74e3242428d8e3c102f40e966d1

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	zcat ../$(PATCH) | patch -Np1
	sed -i 's,2010,002D,' font/devutf8/R.proto
	sed -i 's,2212,002D,' font/devutf8/R.proto
ifndef CROSS
	PAGE=$(pagesize) ./configure --prefix=/usr --enable-multibyte
else
	PAGE=$(pagesize) CC="gcc $(64FLAGS)" CXX="g++ $(64FLAGS)" \
	 ./configure --prefix=/usr --libdir=/usr/lib64 --enable-multibyte
endif
	make
	make install
	ln -sf soelim /usr/bin/zsoelim
	ln -sf eqn /usr/bin/geqn
	ln -sf tbl /usr/bin/gtbl

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
