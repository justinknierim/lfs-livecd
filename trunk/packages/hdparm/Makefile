# hdparm Makefile

NM= hdparm
VRS= 6.7
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/hdparm/$(FILE)
SHA-$(FILE)= ecb4b093a2be691aa41e663ec057a5642b3215db

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
