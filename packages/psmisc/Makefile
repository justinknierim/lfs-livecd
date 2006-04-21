# Psmisc Makefile

NM= psmisc
VRS= 22.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= a9fbc679297fcf1e4d42a1beb29e28358174ee33

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
	mv -v /bin/pstree* /usr/bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
