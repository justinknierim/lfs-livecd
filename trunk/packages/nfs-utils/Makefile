# NFS Utilities Makefile

# Package versions
NM= nfs-utils
VRS= 1.0.6
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://ftp.kernel.org/pub/linux/utils/nfs/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/sbin/exportfs ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 groupadd -g 65534 nogroup && \
	 useradd -c nobody -d /home -g nogroup -s /bin/bash -u 65534 nobody && \
	 ./configure --prefix=/usr --sysconfdir=/etc && \
	 make && \
	 make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
