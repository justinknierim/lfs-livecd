# Linux-Libc-Headers Makefile

# Package versions
NM= linux-libc-headers
VRS= 2.6.10.0
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://ep09.pld-linux.org/~mmazur/$(NM)/$(FILE)

# RULES

.PHONY: stage1 chroot stage2 clean

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(MP)/$(DLP)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(MP)/$(DLP) ; fi
	@if [ ! -d $(WD)/include/asm ] ; then tar xjvf $(MP)/$(DLP)/$(FILE) && cd $(DIR) && \
	 cp -R include/asm-i386 $(WD)/include/asm && cp -R include/linux $(WD)/include ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(MKTREE) && make ch-linux-libc-headers $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f /$(DLP)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) /$(DLP) ; fi
	@if [ ! -d /usr/include/asm ] ; then tar xjvf /$(DLP)/$(FILE) && \
	 cd $(DIR) && cp -R include/asm-i386 /usr/include/asm && cp -R include/linux /usr/include && \
	 chown -R root:root /usr/include/{asm,linux} && \
	 find /usr/include/{asm,linux} -type d -exec chmod 755 {} \; && \
	 find /usr/include/{asm,linux} -type f -exec chmod 644 {} \; ; fi
	@make clean
clean:
	@-rm -rf $(DIR)

