# Traceroute Makefile

# Package versions
NM= traceroute
VRS= 1.4a12
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= ftp://ftp.ee.lbl.gov/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@$(WGET) $(URL)
	@if [ ! -f /usr/bin/traceroute ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 sed -i -e 's/-o bin/-o root/' Makefile.in && \
	 ./configure --prefix=/usr && \
	 make && \
	 make install && make install-man && \
	 mv /usr/sbin/traceroute /usr/bin ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
