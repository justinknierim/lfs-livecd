# msmtp Makefile

# Package versions
NM= msmtp
VRS= 1.4.0
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://easynews.dl.sourceforge.net/sourceforge/msmtp/$(FILE)

# RULES

.PHONY: clean stage2 chroot

	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

# This target is for building the package once we're already inside
# the chroot environment.
stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/msmtp ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --sysconfdir=/etc && \
	 make -j3 && make install ; fi
	@make clean
	 
# Does what it says
clean:
	@-rm -rf $(DIR)
