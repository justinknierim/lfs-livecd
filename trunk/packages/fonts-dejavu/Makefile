# DejaVu fonts Makefile

NM= dejavu-fonts-ttf
VRS= 2.27
DIR= $(NM)-$(VRS)
LOCATION= /usr/share/fonts

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 9689967aea645acc460098ce091bf6abcc50c2ac

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cp -v ttf/*.ttf $(LOCATION)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
