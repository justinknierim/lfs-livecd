# wireless_tools Makefile

NM= wireless_tools
VRS= 28
DIR= $(NM).$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= ad97b9748ad6e5d1b50a4e68035997877b6ee984

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make PREFIX=/usr
	make PREFIX=/usr install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
