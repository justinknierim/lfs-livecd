# Sysvinit Makefile

# Package versions
NM= sysvinit
VRS= 2.86
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH= $(DIR)-reexec06-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH1)

# RULES

.PHONY:  clean stage2 chroot

chroot:
	@chroot "$(MP)" $(chenv2) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /sbin/init ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../$(PATCH) && \
	 sed -i 's@Sending processes@& started by init@g' src/init.c && \
	 ROOT="" make -j3 -C src && ROOT="" make -C src install && \
	 cp $(ROOT)/etc/inittab /etc ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
