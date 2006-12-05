# DDCControl Monitor Database Makefile

NM= ddccontrol-db
VRS= 20060730
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/ddccontrol/$(FILE)
SHA-$(FILE)= da30c27ad166978290281db3209953ed8e8332f0

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
