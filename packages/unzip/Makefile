# UnZip Makefile

NM= unzip
VRS= 5.52
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= b48f6b6446c31d3ebc163d134a2500b7fef57047

PATCH1= $(DIR)-fix_Makefile-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 866108c75e4d0cdafe4b74db73a753ef6cb00e69

PATCH2= $(DIR)-fix_libz-1.patch
URL-$(PATCH2)= $(HTTPBLFS)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= fdd84b0ae1aa71b06e0aef849ee7be417ce122a1

PATCH3= $(DIR)-dont_make_noise-1.patch
URL-$(PATCH3)= $(HTTPBLFS)/$(NM)/$(PATCH3)
SHA-$(PATCH3)= d267d4fc0320906ea2ef37e5292644b86a4fb904

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
