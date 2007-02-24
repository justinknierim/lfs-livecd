# Psmisc Makefile

NM= psmisc
VRS= 22.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 262e5a738c323f5b1f0a112c6fcc906f9860e948

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
