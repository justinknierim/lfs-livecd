# Bash Makefile

# Package versions
NM= bash
VRS= 3.0
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH1= $(DIR)-avoid_WCONTINUED-1.patch
PATCH2= $(DIR)-fixes-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1= $(FTP)/$(NM)/$(PATCH1)
URL2= $(FTP)/$(NM)/$(PATCH2)

# RULES

.PHONY: stage1 clean chroot stage2

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(SRC)/$(PATCH1) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH1) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/bash ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH1) && \
	 ./configure --prefix=$(WD) --without-bash-malloc && make && make install && \
	 ln -s bash $(WD)/bin/sh ; fi
	@make clean

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
	@if [ ! -f $(SRC)/$(PATCH2) ] ; then $(WGET) $(URL2) && \
	 mv $(PATCH2) $(SRC) ; fi
	@if [ ! -f /bin/bashbug ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH2) && patch -Np1 -i $(SRC)/$(PATCH1) && \
	 ./configure --prefix=/usr --bindir=/bin --without-bash-malloc --with-installed-readline && \
	 make && make install ; fi
	@make clean
	

clean:
	@-rm -rf $(DIR)
