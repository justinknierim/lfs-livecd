# ReiserFS Progs Makefile

# Package versions
NM= reiserfsprogs
VRS= 3.6.19
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://ftp.namesys.com/pub/reiserfsprogs/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /sbin/mkreiserfs ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --sbindir=/sbin && \
	 make -j3 && make install && \
	 ln -s reiserfsck /sbin/fsck.reiserfs && \
	 ln -s mkreiserfs /sbin/mkfs.reiserfs ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
