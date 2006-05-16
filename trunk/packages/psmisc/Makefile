# Psmisc Makefile

NM= psmisc
VRS= 22.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 1ae222803c5b5967a1b93e69f08330e0cdc1a554

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	./configure --prefix=/usr --exec-prefix=""
	make $(PM)
	make install
	mv -v /bin/pstree* /usr/bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
