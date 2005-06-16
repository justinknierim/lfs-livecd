# isoinfo Makefile

# Package versions
NM= isoinfo
VRS= 0.03.02
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= ftp://metalab.unc.edu/pub/Linux/utils/disk-management/$(FILE)

#RULES

.PHONY: clean chroot klibc-isoinfo

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

klibc-isoinfo:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/lib/klibc/bin/isoinfo ] ; then unpack $(FILE) && cd $(DIR) && \
	 patch -Np1 -i ../../klibc/$(NM)-$(VRS)-fixes-1.patch && \
	 make CC="klcc -shared" -f Makefile.Linux isoinfo && \
	 install isoinfo /usr/lib/klibc/bin ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
