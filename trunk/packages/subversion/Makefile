# Subversion Makefile

NM= subversion
VRS= 1.4.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 1ba850187b3cedb3265850acf32341b7dbe4f945

FILE2= $(NM)-deps-$(VRS).tar.bz2
URL-$(FILE2)= $(HTTPBLFS)/$(NM)/$(FILE2)
SHA-$(FILE2)= 85f5ec38794f4350432c32dc581f4f9f898d171e

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE2)
	$(std_build)

compile-stage2:
	unpack ../$(FILE2) --strip-components=1
	./configure --prefix=/usr
	make
	make install
	install -v -d -m755 /usr/share/doc/$(DIR)
	cp -v -R doc/* /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
