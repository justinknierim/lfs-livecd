# BLFS Bootscripts Makefile

# Package versions
NM= blfs-bootscripts
VRS= 20041227
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://www.linuxfromscratch.org/blfs/downloads/svn/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@tar xjvf $(FILE) && cd $(DIR) && \
	 make install-gpm && \
	 make install-sshd && \
	 make install-service-dhcpcd && \
	 make install-random && \
	 make install-portmap && \
	 make install-nfs-server && \
	 make install-nfs-client
	@make clean

clean:
	@-rm -rf $(DIR)
