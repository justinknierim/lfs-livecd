# Linux Kernel Makefile

# Package versions
NM= linux
VRS= $(KVERS)
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH1= squashfs2.1-patch
URL= http://www.kernel.org/pub/linux/kernel/v2.6/$(FILE)
URL1= http://ftp.roedu.net/pub/mirrors/ftp.namesys.com/pub/reiser4-for-2.6/2.6.11/broken-out
#URL1= http://ftp.namesys.com/pub/reiser4-for-2.6/2.6.11/broken-out

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@-mkdir /boot/isolinux
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && mv $(FILE) $(SRC) ; fi
	@if [ ! -f /boot/isolinux/linux ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 if [ ! -f ../serie ] ; then $(WGET) $(URL1).2/serie && mv serie ../ ; fi && \
	 for i in `cat ../serie` ; do if [ ! -f ../$$i ] ; then $(WGET) $(URL1).2/$$i && \
	 mv $$i ../ ; fi && patch -Np1 -i ../$$i ; done && \
	 patch -Np1 -i $(ROOT)/$(PKG)/squashfs/squashfs2.1/linux-2.6.9/$(PATCH1) && \
	 make mrproper && \
	 cp $(ROOT)/linux/config .config && \
	 make -j3 && \
	 make modules_install && \
	 cp arch/i386/boot/bzImage /boot/isolinux/linux && \
	 cd .. && ./debian-style-headers.sh linux-$(KVERS) ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
