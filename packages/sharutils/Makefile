# sharutils Makefile

# Package versions
NM= sharutils
VRS= 4.3.80
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://ftp.gnu.org/gnu/sharutils/REL-$(VRS)/$(FILE)

# RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "======> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /usr/bin/clear ] ; then tar -xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make -j3 && \
	 make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
