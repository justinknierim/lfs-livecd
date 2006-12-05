# FireFly fonts Makefile

NM= fireflysung
VRS= 1.3.0
DIR= $(NM)-$(VRS)
LOCATION= /usr/share/fonts

FILE= $(DIR).tar.gz
URL-$(FILE)= http://cle.linux.org.tw/fonts/FireFly/$(FILE)
SHA-$(FILE)= a513386c18257febcbedb72b7a4e4aa21e930002

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
