# xchat Makefile

NM= xchat
VRS= 2.6.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://xchat.org/files/source/2.6/$(FILE)
SHA-$(FILE)= 1bf135b3947f75f1b6c8a60c436a7a1f2613a5ae

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make $(PM)
	make install
	cp -ra $(ROOT)/root/.xchat2 /root

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
