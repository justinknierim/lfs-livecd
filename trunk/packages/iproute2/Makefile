# Iproute2 Makefile

NM= iproute2
VRS= 2.6.16
DATE= 060323
DIR= $(NM)-$(VRS)-$(DATE)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 76d866bb3b46a7b2e73d79a4faf6fa8971527633

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build) 
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
ifndef CROSS
	make $(PM) SBINDIR=/sbin
else
	make $(PM) CC="gcc $(64FLAGS)" SBINDIR=/sbin
endif
	make SBINDIR=/sbin install
	mv -v /sbin/arpd /usr/sbin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
