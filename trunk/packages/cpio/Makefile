# cpio Makefile

# Package versions
NM= cpio
VRS= 2.6
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://ftp.gnu.org/pub/gnu/cpio/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /bin/cpio ] ; then unpack $(FILE) && cd $(DIR) && \
	 sed -i -e "s/invalid_arg/argmatch_invalid/" src/mt.c && \
	 ./configure CPIO_MT_PROG=mt --prefix=/usr --bindir=/bin --libexecdir=/tmp --with-rmt=/usr/sbin/rmt && \
	 make -j3 && \
	 make install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
