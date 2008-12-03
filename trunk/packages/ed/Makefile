# Ed Makefile

NM= ed
VRS= 1.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 0b66e79ebfe87eb80eb49be6ca7bb46df6f90e28

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
	make install-man

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
