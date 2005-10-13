# Groff Makefile

NM= groff
VRS= 1.19.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= b7303af986de7b7c7722c2dbad07844fac6b6343

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) 
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
ifndef CROSS
	PAGE=$(pagesize) ./configure --prefix=/usr
else
	PAGE=$(pagesize) CC="gcc ${BUILD64}" CXX="g++ ${BUILD64}" \
	 ./configure --prefix=/usr --libdir=/usr/lib64
endif
	make
	make install
	ln -s soelim /usr/bin/zsoelim
	ln -s eqn /usr/bin/geqn
	ln -s tbl /usr/bin/gtbl

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
