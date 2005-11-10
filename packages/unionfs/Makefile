# Unionfs Makefile

NM= unionfs
VRS= 1.1.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= ftp://ftp.fsl.cs.sunysb.edu/pub/$(NM)/$(FILE)
SHA-$(FILE)= ca384dafb3a01dbce6ebbb9ebe9cf2049baff994

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) 
	$(std_build) 

compile-stage2:
	make KVERS=$(KVERS) PREFIX=/usr EXTRACFLAGS=-DNODEBUG
	make KVERS=$(KVERS) PREFIX=/usr EXTRACFLAGS=-DNODEBUG install
	strip --strip-debug /lib/modules/$(KVERS)/kernel/fs/unionfs.ko

patch-kernel: $(FILE)
	$(std_build)
	-rm -f $@

compile-patch-kernel:
	./patch-kernel.sh $(ROOT)/$(PKG)/linux/linux-$(KVERS)/

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2 compile-patch-kernel
