# gaim Makefile

NM= gaim
VRS= 1.5.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://puzzle.dl.sourceforge.net/sourceforge/gaim/$(FILE)
SHA-$(FILE)= a280d005f01be7fa89c9fa210efb86cc6a9eb9c7

PATCH1= $(DIR)-simhtml-1.patch
# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr
	make
	make install
	svn export --force $(ROOT)/root/.gaim /root/.gaim

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
