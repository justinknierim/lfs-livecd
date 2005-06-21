# BLFS Bootscripts Makefile

# Package versions
NM= blfs-bootscripts
VRS= 20050619
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH=$(DIR)-add-autosshd-1.patch
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
	@if [ ! -f /etc/rc.d/init.d/nfs-client ] ; then unpack $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH) && \
	 make install-service-dhcpcd && \
	 make install-service-pppoe && \
	 make install-gpm && \
	 make install-autosshd && \
	 install -m754 blfs/init.d/sshd /etc/rc.d/init.d/ && \
	 install -m754 blfs/init.d/random /etc/rc.d/init.d/ && \
	 install -m754 blfs/init.d/portmap /etc/rc.d/init.d/ && \
	 install -m754 blfs/init.d/nfs-server /etc/rc.d/init.d/ && \
	 install -m754 blfs/init.d/nfs-client /etc/rc.d/init.d ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
