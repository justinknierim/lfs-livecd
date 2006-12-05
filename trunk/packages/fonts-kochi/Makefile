# Kochi fonts Makefile

NM= kochi-substitute
VRS= 20030628
DIR= $(NM)-$(VRS)
LOCATION= /usr/share/fonts

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://osdn.dl.sourceforge.jp/efont/4845/$(FILE)
SHA-$(FILE)= b7e2eb45092779fd5f87a00cdc8faf1a625bbc74

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
