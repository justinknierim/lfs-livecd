# Iproute2 Makefile

NM= iproute2
VRS= 2.6.18
DATE= 061002
DIR= $(NM)-$(VRS)-$(DATE)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 94f9b91d59e0e63b441130e158422a62a7a31b98

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build) 
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	make $(PM) SBINDIR=/sbin
	make SBINDIR=/sbin install
	mv -v /sbin/arpd /usr/sbin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
