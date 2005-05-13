# Klibc Makefile

# Package versions
NM= klibc
VRS= 1.0
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://www.kernel.org/pub/linux/libs/$(NM)/$(FILE)

# RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -d /usr/lib/klibc ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ln -nsf ../../linux/linux-$(KVERS) linux && make && make install && \
	 make -C ../../util-linux klibc-losetup && \
	 make -C ../../isoinfo klibc-isoinfo ; fi
	@make clean
	

clean:
	@-rm -rf $(DIR)
