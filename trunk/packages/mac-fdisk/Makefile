# mac-fdisk Makefile

NM= mac-fdisk
VRS= 0.1
DIR= $(NM)-$(VRS).orig

FILE= $(NM)_$(VRS).orig.tar.gz
URL-$(FILE)= http://ftp.debian.org/debian/pool/main/m/$(NM)/$(FILE)
SHA-$(FILE)= 47013d3d74892d53c31a73e75c32fda2bf173252

PATCH1= $(NM)_$(VRS)-11.diff.gz
URL-$(PATCH1)= http://ftp.debian.org/debian/pool/main/m/$(NM)/$(PATCH1)
SHA-$(PATCH1)= e69e4ac0e827b4e6499bfddbc16573585a33fc7b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	zcat ../$(PATCH1) > ../$(NM)_$(VRS)-11.diff
	patch -Np1 -i ../$(NM)_$(VRS)-11.diff
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
