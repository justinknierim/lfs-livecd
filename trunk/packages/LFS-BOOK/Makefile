# LFS Book Makefile

# Package versions
NM= LFS-BOOK
VRS= testing
DIR= $(NM)-$(VRS)-HTML
URL= svn://svn.linuxfromscratch.org/LFS/branches/$(VRS)/BOOK



#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -d $(DIR) ] ; then svn co $(URL) $(DIR) ; fi
	@if [ ! -d /usr/share/$(DIR) ] ; then cd $(DIR) && \
	 make BASEDIR=/usr/share/$(DIR) ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
