# pidgin Makefile

NM= pidgin
VRS= 2.0.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://puzzle.dl.sourceforge.net/sourceforge/pidgin/$(FILE)
SHA-$(FILE)= 7f5cdc3e8fb8b8af9646bb0635b2852c24f7e059

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
