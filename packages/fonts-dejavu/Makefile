# DejaVu fonts Makefile

NM= dejavu-ttf
VRS= 2.10
DIR= $(NM)-$(VRS)
LOCATION= /usr/share/fonts

FILE= $(DIR).tar.gz
URL-$(FILE)= http://heanet.dl.sourceforge.net/sourceforge/dejavu/$(FILE)
SHA-$(FILE)= f96d6c27563c8f22652fda10e9d54f0cc1d016e0

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cp -v ./*.ttf $(LOCATION)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
