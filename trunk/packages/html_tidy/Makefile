# HTML Tidy Makefile

# Package versions
NM= tidy
VRS=
DIR= $(NM)
FILE= $(NM)_src.tgz
FILE1= $(NM)_docs.tgz
URL= http://tidy.sourceforge.net/src/$(FILE)
URL1= http://tidy.sourceforge.net/docs/$(FILE1)



#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-html_$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(FILE1) ] ; then $(WGET) $(URL1) ; fi
	@if [ ! -f /usr/bin/tidy ] ; then unpack $(FILE) && \
	 unpack $(FILE1) && cd $(DIR) && \
	 sh build/gnuauto/setup.sh && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install && \
	 install -d -m755 /usr/share/doc/tidy && \
	 cp -R htmldoc /usr/share/doc/tidy && \
	 chown -R root:root /usr/share/doc/tidy ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
