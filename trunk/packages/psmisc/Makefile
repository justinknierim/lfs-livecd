# Psmisc Makefile

NM= psmisc
VRS= 21.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= de7b74d7fee5b46cefa0c3bca025ce075e2075ed

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
ifndef CROSS
	./configure --prefix=/usr --exec-prefix=""
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr \
	 --exec-prefix=""
endif
	make $(PM)
	make install
	mv /bin/pstree* /usr/bin
	ln -sf pstree /usr/bin/pstree.x11

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
