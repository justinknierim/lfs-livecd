# nALFS Makefile

NM= nALFS
VRS= 1.2.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e9847c5830f2b1c5a89fe3bb7fa397648b4099e7

PATCH1= $(DIR)-locale-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH1)
SHA-$(PATCH1)= c3f4d4fb0584fabad532009c534f65181b7ea926
# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build) 

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --with-libxml2 \
	 --with-curl --with-ssl
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
