# LFS-Bootscripts Makefile

# Package versions
NM= lfs-bootscripts
VRS= 2.2.3
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
	@if [ ! -d /etc/sysconfig ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 make install && make install-hotplug && make install-syslog-ng
	@make clean 

clean:
	@-rm -rf $(DIR)
