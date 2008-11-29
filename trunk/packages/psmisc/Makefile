# Psmisc Makefile

NM= psmisc
VRS= 22.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= cb15c23e9cfe618e9de5f066525bce7dc7b77421

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --exec-prefix=""
	make
	make install
	mv -v /bin/pstree* /usr/bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
