# Shadow Makefile

# Package versions
NM= shadow
VRS= 4.0.7
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= ftp://ftp.pld.org.pl/software/$(NM)/$(FILE)

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
	 ./configure --libdir=/lib --enable-shared && \
	 sed -i 's/groups$$(EXEEXT) //' src/Makefile && \
	 sed -i '/groups/d' man/Makefile && \
	 make -j3 && make install && \
	 cp etc/{limits,login.access} /etc && \
	 cp etc/login.defs.linux /etc/login.defs && \
	 sed -i -e 's@#MD5_CRYPT_ENAB.no@MD5_CRYPT_ENAB yes@' -e 's@/var/spool/mail@/var/mail@' /etc/login.defs && \
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
