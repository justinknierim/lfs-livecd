# Shadow Makefile

# Package versions
NM= shadow
VRS= 4.0.6
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
	@if [ ! -d /etc/default ] ; then tar xjvf $(SRC)/$(FILE) && cd $(DIR) && \
	 ./configure --libdir=/usr/lib --enable-shared && \
	 make -j3 && make install && \
	 cp etc/{limits,login.access} /etc && \
	 cp etc/login.defs.linux /etc/login.defs && \
	 sed -i -e 's@#MD5_CRYPT_ENAB.no@MD5_CRYPT_ENAB yes@' -e 's@/var/spool/mail@/var/mail@' /etc/login.defs && \
	 mv /usr/bin/passwd /bin && \
	 mv /usr/lib/libshadow.so.0* /lib && \
	 ln -sf ../../lib/libshadow.so.0 /usr/lib/libshadow.so && \
	 mkdir /etc/default && \
	 rm /bin/groups && \
	 pwconv && grpconv && \
	 echo "#!$(WD)/bin/expect" > rootpasswd && \
	 echo "spawn passwd root" >> rootpasswd && \
	 echo "expect \"password:\"" >> rootpasswd && \
	 echo "send \"\\n\"" >> rootpasswd && \
	 echo "expect \"password:\"" >> rootpasswd && \
	 echo "send \"\\n\"" >> rootpasswd && \
	 echo "expect \"password:\"" >> rootpasswd && \
	 echo "send \"\\n\"" >> rootpasswd && \
	 echo "expect eof" >> rootpasswd && \
	 chmod 755 rootpasswd && ./rootpasswd ; fi
	@make clean
	 

clean:
	@-rm -rf $(DIR)
