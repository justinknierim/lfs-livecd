# ntfsprogs Makefile

NM= ntfsprogs
VRS= 1.13.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://switch.dl.sourceforge.net/sourceforge/linux-ntfs/$(FILE)
SHA-$(FILE)= a4e50f6fc10fcc1e1f562ad64bcbf9a0d46ca72a

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
