# Udev Makefile

# Package versions
NM= udev
VRS= 050
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
FILE1= $(NM)-config-2.permissions
FILE2= $(NM)-config-1.rules
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(FILE1)
URL2= $(FTP)/$(NM)/$(FILE2)

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
	@if [ ! -f $(SRC)/$(FILE1) ] ; then $(WGET) $(URL1) && \
	 mv $(FILE1) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(FILE2) ] ; then $(WGET) $(URL2) && \
	 mv $(FILE2) $(SRC) ; fi
	@if [ ! -f /sbin/udevstart ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 make udevdir=/dev && make udevdir=/dev install && \
	 cp $(SRC)/$(FILE1) /etc/udev/permissions.d/25-lfs.permissions && \
	 cp $(SRC)/$(FILE2) /etc/udev/rules.d/25-lfs.rules ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
