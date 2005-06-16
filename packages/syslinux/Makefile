# Syslinux Makefile

# Package versions
NM= syslinux
VRS= 3.07
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://www.kernel.org/pub/linux/utils/boot/syslinux/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /boot/isolinux/isolinux.bin ] ; then unpack $(FILE) && cd $(DIR) && \
	 cp isolinux.bin /boot/isolinux ; fi
	@cp $(ROOT)/isolinux/{isolinux.cfg,*.msg,splash.lss} /boot/isolinux
	@make clean

clean:
	@-rm -rf $(DIR)
