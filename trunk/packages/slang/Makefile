# Slang Makefile

# Package versions
NM= slang
VRS= 1.4.9
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= ftp://space.mit.edu/pub/davis/slang/v1.4/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/lib/libslang.so.1.4.9 ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ./configure --prefix=/usr && \
	 make && make install && \
	 make elf && make install-elf && \
	 chmod 755 /usr/lib/libslang.so.1.4.9 && /sbin/ldconfig ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
