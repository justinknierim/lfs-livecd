# UnZip Makefile

NM= unzip
VRS= 5.52
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/T-V/$(FILE)
SHA-$(FILE)= b48f6b6446c31d3ebc163d134a2500b7fef57047

PATCH1= $(DIR)-fix_Makefile-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/T-V/$(PATCH1)
SHA-$(PATCH1)= c31f606dfc179e6068b006a5c9c35f551adc82f7

PATCH2= $(DIR)-fix_libz-1.patch
URL-$(PATCH2)= $(HTTPBLFS)/T-V/$(PATCH2)
SHA-$(PATCH2)= b318855331e0b007a3389e4b66708f6bca1517bd

PATCH3= $(DIR)-dont_make_noise-1.patch
URL-$(PATCH3)= $(HTTPBLFS)/T-V/$(PATCH3)
SHA-$(PATCH3)= e1bef189a3a8635beae6efc54b92f304557a9895

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2) $(PATCH3)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH3)
	cp unix/Makefile .
ifneq ($(LFS-ARCH),x86)
	make prefix=/usr LOCAL_UNZIP=-DUSE_UNSHRINK linux_noasm
else
	make prefix=/usr LOCAL_UNZIP=-DUSE_UNSHRINK linux
	make prefix=/usr LOCAL_UNZIP=-DUSE_UNSHRINK linux_shlibz
endif
	make prefix=/usr LOCAL_UNZIP=-DUSE_UNSHRINK install
ifeq ($(LFS-ARCH),x86)
	cp -d libunzip.so* /usr/lib
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
