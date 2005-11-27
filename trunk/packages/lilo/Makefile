# lilo Makefile

NM= lilo
VRS= 22.7.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).src.tar.gz
URL-$(FILE)= http://home.san.rr.com/johninsd/pub/linux/lilo/$(FILE)
SHA-$(FILE)= b431bb0756e1f42c38fc4645063acaea7f2ddcc7

PATCH1= $(NM)-22.6.1-devmapper.patch
URL-$(PATCH1)= http://www.saout.de/misc/$(PATCH1)
SHA-$(PATCH1)= a4fca3ffb2d29c2866d2bfeb1e92fdbd048a3d36
# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
ifneq ($(LFS-ARCH),ppc)
	$(std_build)
endif

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	make ROOT="" $(PM)
	make ROOT="" install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
