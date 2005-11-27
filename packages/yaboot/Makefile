# Yaboot Makefile

NM= yaboot
VRS= 1.3.13
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://penguinppc.org/bootloaders/yaboot/$(FILE)
SHA-$(FILE)= e2269e8dc039a0922d700de831bb185c8a787ca2

PATCH1= $(DIR)-fix1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	make PREFIX=usr
	make PREFIX=usr install
	cp ../ofboot.b /boot/
	cp /usr/lib/yaboot/yaboot /boot/
	cp ../yaboot.conf /boot/
	sed 's|Version:.*|Version: $(VERSION)|' ../boot.msg >/boot/boot.msg

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
