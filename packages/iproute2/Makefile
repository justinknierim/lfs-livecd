# Iproute2 Makefile

NM= iproute
VRS= 2.6.20
DATE= 070313
DIR= $(NM)-$(VRS)-$(DATE)

FILE= $(NM)2-$(VRS)-$(DATE).tar.gz
URL-$(FILE)= http://developer.osdl.org/dev/iproute2/download/$(FILE)
SHA-$(FILE)= 6c46d381a9840c94a12faf3b2d64577c4e74323d

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
