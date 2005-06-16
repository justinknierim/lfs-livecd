# Shadow Makefile

# Package versions
NM= shadow
VRS= 4.0.7
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
PATCH=${DIR}-fix_lastlog-1.patch
URL= $(FTP)/$(NM)/$(FILE)
URL1=$(FTP)/$(NM)/$(PATCH)

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
	@if [ ! -f $(SRC)/$(PATCH) ] ; then $(WGET) $(URL1) && \
	 mv $(PATCH) $(SRC) ; fi
	@if [ ! -d /etc/default ] ; then unpack $(SRC)/$(FILE) && cd $(DIR) && \
	 patch -Np1 -i $(SRC)/$(PATCH) && \
	 ./configure --libdir=/lib --enable-shared && \
	 sed -i 's/groups$$(EXEEXT) //' src/Makefile && \
	 sed -i '/groups/d' man/Makefile && \
	 make -j3 && make install && \
	 cp etc/{limits,login.access} /etc && \
	 cp etc/login.defs.linux /etc/login.defs && \
	 sed -i -e 's@#MD5_CRYPT_ENAB.no@MD5_CRYPT_ENAB yes@' \
	     -e 's@/var/spool/mail@/var/mail@' \
	     -e 's@MAIL_CHECK_ENAB..yes@MAIL_CHECK_ENAB no@' /etc/login.defs && \
	 mv /usr/bin/passwd /bin && \
	 mv /lib/libshadow.*a /usr/lib && \
	 rm /lib/libshadow.so && \
	 ln -sf ../../lib/libshadow.so.0 /usr/lib/libshadow.so && \
	 mkdir /etc/default && \
	 pwconv && grpconv && \
	 echo "root:" | chpasswd ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
