# Berkeley DB Makefile

# Package versions
NM= db
VRS= 4.3.27
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= ftp://sleepycat1.inetu.net/releases/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/db_stat ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 cd build_unix && \
	 ../dist/configure --prefix=/usr --enable-compat185 --enable-cxx && \
	 make -j3 LIBSO_LIBS="-lpthread" LIBXSO_LIBS="-lpthread" && \
	 make docdir=/usr/share/doc/db-4.3.27 install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
