# Reiser4progs Makefile

# Package versions
NM= reiser4progs
VRS= 1.0.3
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://linuxberg.vc-graz.ac.at/mirror/reiserfs/reiser4progs/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /sbin/mkfs.reiser4 ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr --sbindir=/sbin && \
	 make -j3 && \
	 make install && ln -s mkfs.reiser4 /sbin/mkreiser4fs ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
