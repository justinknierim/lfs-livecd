# Firebox Makefile

# Package versions
NM= firefox
VRS= 1.0
DIR= mozilla
FILE= $(NM)-$(VRS)-source.tar.bz2
URL= http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/1.0/source/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/bin/firefox ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 export MOZILLA_OFFICIAL="1" && \
	 export BUILD_OFFICIAL="1" && \
	 export MOZ_PHOENIX="1" && \
	 ./configure --prefix=/usr --with-default-mozilla-five-home=/usr/lib/firefox-1.0 \
	 --with-user-appdir=.firefox --with-system-zlib --with-system-jpeg --with-system-png \
	 --enable-application=browser --enable-default-toolkit=gtk2 --enable-extensions=all,-typeaheadfind \
	 --enable-crypto --enable-xft --enable-xinerama --enable-optimize --enable-reorder --enable-strip \
	 --enable-cpp-rtti --enable-single-profile --disable-freetype2 --disable-accessibility --disable-debug \
	 --disable-tests --disable-logging --disable-pedantic --disable-installer --disable-mailnews \
	 --disable-ldap --disable-composer --disable-profilesharing && \
	 make -j3 && make install && \
	 install -d /usr/include/firefox-1.0/nss && \
	 cp -Lf dist/private/nss/*.h dist/public/nss/*.h /usr/include/firefox-1.0/nss ; fi
	@cp -ra $(ROOT)/root/.firefox /root
	@cp -ra $(ROOT)/root/.mozilla /root
	@make clean

clean:
	@-rm -rf $(DIR)
