# SquashFS Makefile

# Package versions
NM= squashfs
VRS= 2.1
DIR= $(NM)$(VRS)
PATCH=
FILE= $(DIR).tar.gz
URL= http://easynews.dl.sourceforge.net/sourceforge/squashfs/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@tar xzvf $(FILE) && cd $(DIR) && \
	 cd $(NM)-tools && make && cp mksquashfs $(WD)/bin

clean:
	@-rm -rf $(DIR)
