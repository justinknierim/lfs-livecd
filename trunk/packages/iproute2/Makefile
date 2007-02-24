# Iproute2 Makefile

NM= iproute2
VRS= 2.6.19
DATE= 061214
DIR= $(NM)-$(VRS)-$(DATE)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://developer.osdl.org/dev/iproute2/download/$(FILE)
SHA-$(FILE)= f48c783c37e09a212cde65ae0370468af634fd65

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build) 

compile-stage2:
	make SBINDIR=/sbin
	make SBINDIR=/sbin install
	mv -v /sbin/arpd /usr/sbin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
