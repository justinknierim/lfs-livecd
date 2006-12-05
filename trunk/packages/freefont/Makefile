# FreeFont Makefile

NM= freefont
VRS= 20060126
DIR= $(NM)-$(VRS)
LOCATION= /usr/share/fonts

FILE= $(NM)-ttf-$(VRS).tar.gz
URL-$(FILE)= http://download.savannah.gnu.org/releases/$(NM)/$(FILE)
SHA-$(FILE)= f3b53235bc1bebd228a8942068bd049693d71363

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
