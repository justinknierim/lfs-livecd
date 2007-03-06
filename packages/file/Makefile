# File Makefile

NM= file
VRS= 4.20
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= ftp://ftp.gw.com/mirrors/pub/unix/file/$(FILE)
SHA-$(FILE)= af5878e3c61c725a82ff185fcef5b631ad8468ab

PATCH1= $(DIR)-reg_startend-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/development/$(PATCH1)
SHA-$(PATCH1)= e55056a4f3d4204870f8db2ad51113d46b8032f5

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
