# Hotplug Makefile

# Package versions
NM= hotplug
VRS= 2004_09_23
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
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
	@if [ ! -f /sbin/hotplug ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 make install && \
	 cp etc/hotplug/pnp.distmap /etc/hotplug && \
	 rm -rf /etc/init.d && \
	 rm -f /etc/hotplug/net.agent ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
