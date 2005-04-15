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
	@if [ ! -f /etc/rc.d/init.d/mountsqfs ] ; then tar xjvf ${SRC}/${FILE} && \
	 cd ${DIR} && make install-livecd ; fi

clean:
	@-rm -rf bootscripts
