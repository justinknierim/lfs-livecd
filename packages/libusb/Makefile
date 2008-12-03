# libusb Makefile

NM= libusb
VRS= 0.1.12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 599a5168590f66bc6f1f9a299579fd8500614807

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --disable-build-docs
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
