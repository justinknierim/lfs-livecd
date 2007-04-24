# gaim Makefile

NM= gaim
VRS= 2.0.0beta6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://puzzle.dl.sourceforge.net/sourceforge/gaim/$(FILE)
SHA-$(FILE)= 39345fe6e0519f2e126f7f60f7d9905e3460517b

PATCH1= $(DIR)-simhtml-1.patch
# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	# D-BUS support is disabled because it wants Python
	./configure --prefix=/usr --disable-dbus
	make
	make install
	svn export --force $(ROOT)/root/.gaim /root/.gaim

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
