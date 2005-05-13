# DejaVu fonts Makefile

# Package versions
NM= dejavu-ttf
VRS= 1.9
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://heanet.dl.sourceforge.net/sourceforge/dejavu/$(FILE)
LOCATION= /usr/X11R6/lib/X11/fonts/TTF

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-fonts-dejavu $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(LOCATION)/DejaVuSansMono-Roman.ttf ] ; then \
	 tar -xzvf $(FILE) && \
	 cp $(DIR)/*.ttf $(LOCATION) ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
