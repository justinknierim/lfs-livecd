# HTML Tidy Makefile

NM= tidy
VRS= 051026
DIR= $(NM)

FILE= $(NM)_src_$(VRS).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= fe1f4316e0584670dfb47de386319895c31ea451

FILE1= $(NM)_docs_051020.tar.bz2
URL-$(FILE1)= $(HTTPBLFS)/$(NM)/$(FILE1)
SHA-$(FILE1)= 274dc5093ad53045478ba39accec2c411f14c643

include $(CROSSVARS) 

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-html_$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	unpack $(FILE1)
	$(std_build)

compile-stage2:
	sh build/gnuauto/setup.sh
	$(ARCH_CC) ./configure --prefix=/usr $(EXTRA_CONF)
	make $(PM)
	make install
	install -d -m755 /usr/share/doc/tidy
	cp -R htmldoc /usr/share/doc/tidy
	chown -R root:root /usr/share/doc/tidy

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
