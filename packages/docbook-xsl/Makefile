# DocBook XSL Stylesheets Makefile

# Package versions
NM= docbook-xsl
VRS= 1.68.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2
URL= http://easynews.dl.sourceforge.net/sourceforge/docbook/$(FILE)



#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -d /usr/share/xml/docbook/xsl-stylesheets-current ] ; then tar xjvf $(FILE) && cd $(DIR) && \
	 ../install && \
	 ln -s xsl-stylesheets-$(VRS) /usr/share/xml/docbook/xsl-stylesheets-current; fi
	@make clean

clean:
	@-rm -rf $(DIR)
