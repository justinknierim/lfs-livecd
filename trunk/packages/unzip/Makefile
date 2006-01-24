# UnZip Makefile

NM= unzip
VRS= 5.52
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= d3d0b410f51b98dae3b056b5e9768fccb1402beb

PATCH1= $(DIR)-fix_Makefile-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 48f4cbbc21f2562a6957dcf7532df6f84c3b1cdc

PATCH2= $(DIR)-fix_libz-1.patch
URL-$(PATCH2)= $(HTTPBLFS)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 166a01de3d461d9083846f542a625b1c5f87634b

PATCH3= $(DIR)-dont_make_noise-1.patch
URL-$(PATCH3)= $(HTTPBLFS)/$(NM)/$(PATCH3)
SHA-$(PATCH3)= 9e8f063e70370968a860d3bddeb37c43391f7a3c

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
	make prefix=/usr LOCAL_UNZIP=-D_FILE_OFFSET_BITS=64 linux_noasm
else
	make prefix=/usr LOCAL_UNZIP=-D_FILE_OFFSET_BITS=64 linux
	make prefix=/usr LOCAL_UNZIP=-D_FILE_OFFSET_BITS=64 linux_shlibz
endif
	make prefix=/usr install
ifeq ($(LFS-ARCH),x86)
	cp -d libunzip.so* /usr/lib
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
