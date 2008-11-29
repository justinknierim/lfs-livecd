# Iproute2 Makefile

NM= iproute2
VRS= 2.6.26
DIR= $(NM)-$(VRS)

FILE= $(NM)-$(VRS).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 95e0f528066eae7304b5d7c610348b522628c92f

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build) 

compile-stage2:
	make DESTDIR= SBINDIR=/sbin
	make DESTDIR= SBINDIR=/sbin MANDIR=/usr/share/man \
	 DOCDIR=/usr/share/doc/$(DIR) install
	mv -v /sbin/arpd /usr/sbin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
