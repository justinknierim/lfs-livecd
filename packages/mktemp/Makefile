# Mktemp Makefile

# Package versions
NM= mktemp
VRS= 1.5
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH1= $(DIR)-add_tempfile-1.patch
URL= $(HTTP)/$(NM)/$(FILE)
URL1= $(HTTP)/$(NM)/$(PATCH1)

# RULES

.PHONY:  clean stage2 chroot

chroot:
	@chroot "$(MP)" $(chenv1) 'cd $(ROOT) && make ch-$(NM) $(chbash1)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH1) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH1) $(SRC) ; fi
	@if [ ! -f /usr/bin/mktemp ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH1) && \
	 ./configure --prefix=/usr --with-libc && \
	 make -j3 && make install && make install-tempfile ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
