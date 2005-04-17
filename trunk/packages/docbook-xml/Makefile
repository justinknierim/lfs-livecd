# DocBook XML DTD Makefile

# Package versions
NM= docbook-xml
VRS= 4.4
DIR= $(NM)-$(VRS)
FILE= $(DIR).zip
URL= http://www.docbook.org/xml/4.3/$(FILE)



#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /etc/xml/docbook ] ; then mkdir $(DIR) && cd $(DIR) && unzip ../$(FILE) && \
	 ../install ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
