# UnZip Makefile

NM= unzip
VRS= 5.52
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= d3d0b410f51b98dae3b056b5e9768fccb1402beb

PATCH1= $(DIR)-security_fix-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 7f6a287c0b480bc4748abdf69429dfc76383e1d6

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
ifeq ($(CD_ARCH),x86)
	make -f unix/Makefile LOCAL_UNZIP=-D_FILE_OFFSET_BITS=64 linux
else
	make -f unix/Makefile LOCAL_UNZIP=-D_FILE_OFFSET_BITS=64 linux_noasm
endif
	make prefix=/usr MANDIR=/usr/share/man/man1 install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
