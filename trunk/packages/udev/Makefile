# Udev Makefile

# Package versions
NM= udev
VRS= 056
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
FILE1= $(NM)-config-3.rules
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(FILE1)

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
	@if [ ! -f /sbin/udevstart ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 make udevdir=/dev && make udevdir=/dev install && \
	 cp $(SRC)/$(FILE1) /etc/udev/rules.d/25-lfs.rules && \
	 /sbin/udevstart ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
