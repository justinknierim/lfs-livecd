# E2fsprogs Makefile

# Package versions
NM= e2fsprogs
VRS= 1.36
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH1)

# RULES

.PHONY:  clean stage2 chroot

chroot:
	@chroot "$(MP)" $(chenv2) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f /sbin/mke2fs ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 mkdir build && cd build && \
	 ../configure --prefix=/usr --with-root-prefix="" --enable-elf-shlibs --disable-evms && \
	 make && make install && make install-libs ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
