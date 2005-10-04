# DejaVu fonts Makefile

NM= dejavu-ttf
VRS= 1.14
DIR= $(NM)-$(VRS)
LOCATION= /usr/X11R6/lib/X11/fonts/TTF

FILE= $(DIR).tar.gz
URL-$(FILE)= http://heanet.dl.sourceforge.net/sourceforge/dejavu/$(FILE)
SHA-$(FILE)= 51eab6407780e0d5b62395d11e205743c3949a3e

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
