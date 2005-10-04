# xchat Makefile

NM= xchat
VRS= 2.4.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://xchat.org/files/source/2.4/$(FILE)
SHA-$(FILE)= e027a20caa47b4ffea00896ee68269a7ae885e2d

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
