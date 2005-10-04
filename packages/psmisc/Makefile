# Psmisc Makefile

NM= psmisc
VRS= 21.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= c23b3cd41ed8e4d599dd4f2dfc22e397fc1351cf

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --exec-prefix=""
	make $(PM)
	make install
	mv /bin/pstree* /usr/bin
	ln -sf pstree /usr/bin/pstree.x11

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
