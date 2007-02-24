# ncftp Makefile

NM= ncftp
VRS= 3.2.0
DIR= $(NM)-$(VRS)

FILE= $(DIR)-src.tar.bz2
URL-$(FILE)= http://ftp.belnet.be/pub/mirror/ftp.ncftp.com/ncftp/$(FILE)
SHA-$(FILE)= 708222170df81ed957e4f187213d69ea21e4f7dd

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc
	make -C libncftp shared
	make -C libncftp soinstall
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
