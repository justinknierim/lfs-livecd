# hicolor-icon-theme Makefile

NM= hicolor-icon-theme
VRS= 0.10
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 30a1526cd337ecbd9aaecfff2737884b86c72508

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
