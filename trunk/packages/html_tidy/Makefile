# HTML Tidy Makefile

# Package versions
NM= tidy
VRS= 050120
DIR= $(NM)
FILE= $(NM)_src_$(VRS).tgz
FILE2= $(NM)_docs.tgz
URL= http://tidy.sourceforge.net/src/$(FILE)
URL2= http://tidy.sourceforge.net/docs/$(FILE2)



#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-html_$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f $(FILE2) ] ; then $(WGET) $(URL2) ; fi
	@if [ ! -f /usr/bin/tidy ] ; then tar xzvf $(FILE) && \
	 tar xzvf $(FILE2) && cd $(DIR) && \
	 sh build/gnuauto/setup.sh && \
	 ./configure --prefix=/usr && \
	 make -j3 && make install && \
	 install -m644 htmldoc/man_page.txt /usr/share/man/man1/tidy.1 && \
	 install -d -m755 /usr/share/doc/tidy && \
	 cp -R htmldoc /usr/share/doc/tidy && \
	 chown -R root:root /usr/share/doc/tidy ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
