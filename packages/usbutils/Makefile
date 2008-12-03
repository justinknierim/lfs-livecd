# usbutils Makefile

NM= usbutils
VRS= 0.72
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 891b8825d964880146d5c980e52bb9e23d92fe2b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 's|DEST=|&/usr/share/|' update-usbids.sh
	./configure --prefix=/usr
	make
	make install
	install -v -m755 update-usbids.sh /usr/sbin/update-usbids

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
