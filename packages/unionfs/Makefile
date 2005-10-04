# Unionfs Makefile

NM= unionfs
VRS= 1.0.14
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= ftp://ftp.fsl.cs.sunysb.edu/pub/$(NM)/$(FILE)
SHA-$(FILE)= 70b87ec8ae1b5b51b2d7a7b9ef4da80565ee124e

PATCH1= $(DIR)-fix_builtin-1.patch
PATCH2= $(DIR)-fixes-1.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) 
	$(std_build) 

compile-stage2:
	patch -Np1 -i ../$(PATCH2)
	make KVERS=$(KVERS) PREFIX=/usr EXTRACFLAGS=-DNODEBUG
	make KVERS=$(KVERS) PREFIX=/usr EXTRACFLAGS=-DNODEBUG install
	strip --strip-debug /lib/modules/$(KVERS)/kernel/fs/unionfs.ko

patch-kernel: $(FILE) $(PATCH1)
	$(std_build)
	-rm -f $@

compile-patch-kernel:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	./patch-kernel.sh $(ROOT)/$(PKG)/linux/linux-$(KVERS)/

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2 compile-patch-kernel
