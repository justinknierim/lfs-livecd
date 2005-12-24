# FreeFont Makefile

NM= freefont-ttf
VRS= 20050407
DIR= $(NM)-$(VRS)
LOCATION= /usr/share/fonts

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 0ea665c57a5dea77e9336538547d6996e5576961

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	mkdir $(DIR) 
	cd $(DIR) ; unpack ../$(FILE)
	make -C $(DIR) -f ../Makefile compile-$@ >$(DIR)-$@.log 2>&1
	make clean
	touch $@

compile-stage2:
	cp -v sfd/*.ttf $(LOCATION)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
