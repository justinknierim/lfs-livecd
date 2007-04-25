# gaim-libnotify Makefile

NM= gaim
VRS= 0.12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://puzzle.dl.sourceforge.net/sourceforge/gaim-libnotify/$(FILE)
SHA-$(FILE)= c20d82ff8fc69a6fa2a67bdc4c6b503c8b2c9ee6

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

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
