# FreeFont Makefile

NM= freefont
VRS= 20080912
DIR= $(NM)-$(VRS)
LOCATION= /usr/share/fonts

FILE= $(NM)-ttf-$(VRS).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= b2566d186d59b7fddf2cffd72728a98b0121b772

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cp -v *.ttf $(LOCATION)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
