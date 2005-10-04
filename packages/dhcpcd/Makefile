# dhcpcd Makefile

NM= dhcpcd
VRS= 1.3.22-pl4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/D-E/$(FILE)
SHA-$(FILE)= f4462063c7b392f1899bc9e6ada3309d42e92794

PATCH1= $(DIR)-fhs-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/D-E/$(PATCH1)
SHA-$(PATCH1)= cec6d31a5146993cee6b147723c66742a24eed85

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix="" --sysconfdir=/var/lib \
	 --mandir=/usr/share/man
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
