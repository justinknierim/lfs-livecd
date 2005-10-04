# FreeFont Makefile

NM= freefont
VRS= ttf
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
LOCATION= /usr/X11R6/lib/X11/fonts/TTF

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/savannah/files/freefont/$(FILE)
SHA-$(FILE)= bace5fc544871a646b63f94d4902be0fceca0b3e

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	mkdir $(DIR) 
	cd $(DIR) ; unpack ../$(FILE)
	make -C $(DIR) -f ../Makefile compile-$@
	make clean
	touch $@

compile-stage2:
	cp -v sfd/* $(LOCATION)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
