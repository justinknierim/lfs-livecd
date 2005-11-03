# wireless_tools Makefile

NM= wireless_tools
VRS= 27
DIR= $(NM).$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 0b94fa04df84419e3ef34e272e7be215f6533c4d

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make PREFIX=/usr
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
