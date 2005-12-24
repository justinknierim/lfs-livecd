# Baekmuk fonts Makefile

NM= baekmuk-ttf
VRS= 2.2
DIR= $(NM)-$(VRS)
LOCATION= /usr/share/fonts

FILE= $(DIR).tar.gz
URL-$(FILE)= http://kldp.net/frs/download.php/1429/$(FILE)
SHA-$(FILE)= afdee34f700007de6ea87b43c92a88b7385ba65b

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
