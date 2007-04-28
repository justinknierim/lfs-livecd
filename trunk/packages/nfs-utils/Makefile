# NFS Utilities Makefile

NM= nfs-utils
VRS= 1.0.12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/nfs/$(FILE)
SHA-$(FILE)= 477e3eb387b0ccde2eaeb8e67c6437cc0d2668e3

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --disable-nfsv4 \
	 --disable-gss
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
