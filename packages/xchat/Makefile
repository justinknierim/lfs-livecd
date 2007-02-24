# xchat Makefile

NM= xchat
VRS= 2.6.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://xchat.org/files/source/2.6/$(FILE)
SHA-$(FILE)= ba674165ad9f8e48acd2c0437bea6b1acc2871b9

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
