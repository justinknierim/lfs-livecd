# DejaVu fonts Makefile

NM= dejavu-ttf
VRS= 2.15
DIR= $(NM)-$(VRS)
LOCATION= /usr/share/fonts

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://heanet.dl.sourceforge.net/dejavu/$(FILE)
SHA-$(FILE)= 2133fbae14e51fc364972c4a4ee2fdc3ccee4072

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
