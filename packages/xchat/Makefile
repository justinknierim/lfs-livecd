# xchat Makefile

NM= xchat
VRS= 2.8.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://xchat.org/files/source/2.8/$(FILE)
SHA-$(FILE)= 5cff7a974819ad8788962742df785aabfe844af0

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install
	svn export --force $(ROOT)/root/.xchat2 /root/.xchat2

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
