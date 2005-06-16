# Linux-Libc-Headers Makefile

# Package versions
NM= linux-libc-headers
VRS= 2.6.11.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)

# RULES

.PHONY: stage1 chroot stage2 clean

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -d $(WD)/include/asm ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 cp -R include/asm-i386 $(WD)/include/asm && cp -R include/linux $(WD)/include ; fi
	@make clean

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(MKTREE) && make ch-linux-libc-headers $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -d /usr/include/asm ] ; then unpack $(SRC)/$(FILE) && \
	 cd $(DIR) && cp -R include/asm-i386 /usr/include/asm && cp -R include/linux /usr/include && \
	 chown -R root:root /usr/include/{asm,linux} && \
	 find /usr/include/{asm,linux} -type d -exec chmod 755 {} \; && \
	 find /usr/include/{asm,linux} -type f -exec chmod 644 {} \; ; fi
	@make clean
clean:
	@-rm -rf $(DIR)

