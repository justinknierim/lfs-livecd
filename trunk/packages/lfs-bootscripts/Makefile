# LFS-Bootscripts Makefile

# Package versions
NM= lfs-bootscripts
VRS= 3.2.0
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH1)

# RULES

.PHONY:  clean stage2 chroot

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /etc/rc.d/init.d/functions ] ; then tar xjvf ${SRC}/${FILE} && \
	 cd ${DIR} && make install-livecd && \
	 install -m 755 lfs/init.d/{mountkernfs,udev} /etc/rc.d/init.d && \
	 ln -sf ../init.d/mountkernfs /etc/rc.d/rcsysinit.d/S00mountkernks && \
	 ln -sf ../init.d/udev /etc/rc.d/rcsysinit.d/S10udev && \
	 rm -f /etc/rc.d/*/*mountsqfs /etc/rc.d/*/*startup ; fi

clean:
	@-rm -rf bootscripts
