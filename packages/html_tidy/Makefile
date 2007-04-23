# HTML Tidy Makefile

NM= tidy
VRS= cvs_20070326
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://anduin.linuxfromscratch.org/files/BLFS/sources/$(FILE)
SHA-$(FILE)= 8a775dea48fac5dacff7879813bce60fd44c2ed0

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-html_$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
