# Iproute2 Makefile

NM= iproute2
VRS= 2.6.11
DATE= 050330
DIR= $(NM)-$(VRS)

FILE= $(DIR)-$(DATE).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 99671963174b31fc3ddac6ea168b2bc31d8f6c98

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build) 
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
	./configure
	make $(PM) SBINDIR=/sbin
	make SBINDIR=/sbin install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
