# Coreutils Makefile

# Package versions
NM= coreutils
VRS= 5.2.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH1= $(DIR)-uname-2.patch
PATCH2= $(DIR)-suppress_uptime_kill_su-1.patch
URL= $(HTTP)/$(NM)/$(FILE)
URL1= $(HTTP)/$(NM)/$(PATCH1)
URL2= $(HTTP)/$(NM)/$(PATCH2)

# RULES

.PHONY: stage1 clean stage2 chroot

stage1:
	@echo ""
	@echo "=====> Building $(NM)"
	@echo ""
	@if [ ! -f $(SRC)/$(FILE) ] ; then $(WGET) $(URL) && \
	 mv $(FILE) $(SRC) ; fi
	@if [ ! -f $(WD)/bin/ls ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 DEFAULT_POSIX2_VERSION=199209 ./configure --prefix=$(WD) && make -j3 && make install && \
	 mv ${WD}/bin/uname ${WD}/bin/uname.real && \
	 install -m 755 ${MP}${ROOT}/uname/uname ${WD}/bin/ ; fi
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
	@if [ ! -f /bin/ls ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH1) && patch -Np1 -i $(SRC)/$(PATCH2) && \
	 DEFAULT_POSIX2_VERSION=199209 ./configure --prefix=/usr && \
	 make -j3 && make install && \
	 $(WD)/bin/mv /usr/bin/{[,basename,cat,chgrp,chmod,chown,cp,dd,df} /bin && \
	 $(WD)/bin/mv /usr/bin/{date,echo,false,head,hostname,install,ln} /bin && \
	 $(WD)/bin/mv /usr/bin/{ls,mkdir,mknod,mv,pwd,rm,rmdir,sync} /bin && \
	 mv /usr/bin/{sleep,stty,test,touch,true,uname} /bin && \
	 mv /usr/bin/chroot /usr/sbin && \
	 ln -s ../../bin/install /usr/bin && \
	 mv /bin/uname /bin/uname.real && \
	 install -m 755 ${ROOT}/uname/uname /bin/ ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
