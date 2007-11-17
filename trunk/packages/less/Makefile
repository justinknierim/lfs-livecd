# Less Makefile 

NM= less
VRS= 406
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 7aeab848682c3ac7cd9ba54e4c96199f9fdf25e5

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
