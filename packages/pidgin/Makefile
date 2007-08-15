# pidgin Makefile

NM= pidgin
VRS= 2.1.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://puzzle.dl.sourceforge.net/sourceforge/pidgin/$(FILE)
SHA-$(FILE)= 33f78d07c3c7797a710bb7d2032a8d0bd89a6ab3

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
	svn export --force $(ROOT)/root/.purple /root/.purple

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
