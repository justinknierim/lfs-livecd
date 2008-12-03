# LibXML2 Makefile

NM= libxml2
VRS= 2.6.31
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 97233a210425bad96b35e52aa3e0010ac11bbcc9

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --with-history
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
