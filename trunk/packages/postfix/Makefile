# Postfix Makefile

# Package versions
NM= postfix
VRS= 2.1.5
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
URL= http://www.mirrorspace.org/$(NM)/official/$(FILE)

#RULES

.PHONY: clean chroot stage2

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	@if [ ! -f $(FILE) ] ; then $(WGET) $(URL) ; fi
	@if [ ! -f /usr/sbin/postfix ] ; then tar xzvf $(FILE) && cd $(DIR) && \
	 groupadd postfix && \
	 groupadd postdrop && \
	 groupadd -g 65534 nogroup && \
	 useradd -c postfix -d /dev/null -g postfix -s /bin/false postfix && \
	 useradd -c nobody -d /home -g nogroup -s /bin/bash -u 65534 nobody && \
	 chown postfix:postfix /var/mail && \
	 make -j3 && \
	 sh postfix-install daemon_directory=/usr/sbin manpage_directory=/usr/share/man \
	 sample_directory=/usr/share/doc/postfix -non-interactive && \
	 install -d /usr/share/doc/postfix && cp -rf html/* /usr/share/doc/postfix ; fi
	@make clean

clean:
	@-rm -rf $(DIR)
