# Linux-Libc-Headers Makefile

# Package versions
NM= linux-libc-headers
VRS= 2.6.10.0
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
DLP= $(MKTREE)/$(SRC)/$(FILE)
URL= http://ep09.pld-linux.org/~mmazur/$(NM)/$(FILE)
WGET= wget -c --passive-ftp -O $(DLP) $(URL)
WGETCH= wget -c --passive-ftp -O /mklivecd/sources/$(FILE) $(URL)

#RULES

pre1:
	@su - lfs -c "exec env -i CFLAGS=' $(CFLAGS) ' LFS=$(MP) LC_ALL=POSIX PATH=$(WD)/bin:/bin:/usr/bin /bin/bash -c 'set +h && umask 022 && cd $(MKTREE) && make lfs-$(NM)'"

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(DLP) ] ; then $(WGET) ; fi
	@if [ ! -d $(WD)/include/asm ] ; then tar xjvf $(DLP) && cd $(DIR) && \
	 cp -R include/asm-i386 $(WD)/include/asm && cp -R include/linux $(WD)/include ; fi
	@make clean

prechroot:
	@chroot "$(MP)" $(WD)/bin/env -i HOME=/root TERM="$$TERM" PS1='\u:\w\$$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:$(WD)/bin $(WD)/bin/bash -c 'cd mklivecd && make prep-chroot SHELL=$(WD)/bin/bash && make popdev SHELL=$(WD)/bin/bash && make ch-$(NM) SHELL=$(WD)/bin/bash'

stage2:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f /mklivecd/sources/$(FILE) ] ; then $(WGETCH) ; fi
	@if [ ! -d /usr/include/asm ] ; then tar xjvf /mklivecd/sources/$(FILE) && \
	 cd $(DIR) && cp -R include/asm-i386 /usr/include/asm && cp -R include/linux /usr/include && \
	 chown -R root:root /usr/include/{asm,linux} && \
	 find /usr/include/{asm,linux} -type d -exec chmod 755 {} \; && \
	 find /usr/include/{asm,linux} -type f -exec chmod 644 {} \; ; fi
	@make clean
clean:
	@-rm -rf $(DIR)

