# Man Makefile

# Package versions
NM= man
VRS= 1.5p
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
	@if [ ! -f /usr/bin/man ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 sed -i 's@-is@&R@g' configure && \
	 sed -i 's@MANPATH./usr/man@#&@g' src/man.conf.in && \
	 ./configure -confdir=/etc && make && \
	 make install && \
	 sed -i 's@Tlatin1 -@@' /etc/man.conf && \
	 sed -i 's@Tnippon -@@' /etc/man.conf ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
