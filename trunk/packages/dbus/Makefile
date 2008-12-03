# dbus Makefile

NM= dbus
VRS= 1.2.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 913d796b79802b6ee6ca2b0ef59c670f3fd79774

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
	make
	make install
	install -v -m755 -d /usr/share/doc/$(DIR)
	install -v -m644 doc/{TODO,*.{dtd,html,xml,xsl,txt,c}} \
	 /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
