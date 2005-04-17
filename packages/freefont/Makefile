# FreeFont Makefile

# Package versions
NM= freefont
VRS= ttf
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://ftp.gnu.org/savannah/files/freefont/$(FILE)
LOCATION= /usr/X11R6/lib/X11/fonts/TTF

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(LOCATION)/FreeMono.ttf ] ; then mkdir $(DIR) && cd $(DIR) && \
	 tar -xzvf ../$(FILE) && \
	 cp sfd/* $(LOCATION) ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
